PY=python3
PELICAN=pelican
PELICANOPTS=

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelicanconf.py
PUBLISHCONF=$(BASEDIR)/publishconf.py
PAGESDIR=$(INPUTDIR)/pages
DATE := $(shell date +'%Y-%m-%d %H:%M:%S')
DATEYYMMDD := $(shell date +'%Y%m%d')
SLUG := $(shell echo '${NAME}' | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z)
EXT ?= rst
AUTHOR := ankur

FTP_HOST=ftp.ankursinha.in
FTP_USER=ankurhsj
FTP_TARGET_DIR=/public_html/blog
FTP_PORT=21

SSH_HOST=ankursinha.in
SSH_PORT=22
SSH_USER=ankurhsj
SSH_TARGET_DIR=public_html/blog

S3_BUCKET=my_s3_bucket

CLOUDFILES_USERNAME=my_rackspace_username
CLOUDFILES_API_KEY=my_rackspace_api_key
CLOUDFILES_CONTAINER=my_cloudfiles_container

DROPBOX_DIR=~/Dropbox/Public/
GITHUB_PAGES_BRANCH=gh-pages

DEBUG ?= 0
ifeq ($(DEBUG), 1)
	PELICANOPTS += -D
endif

help:
	@echo 'Makefile for a pelican Web site                                        '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        (re)generate the web site          '
	@echo '   make clean                       remove some generated files        '
	@echo '   make cleanoutput                 remove output folder completely    '
	@echo '   make regenerate                  regenerate files upon modification '
	@echo '   make publish                     generate using production settings '
	@echo '   make serve [PORT=8000]           serve site at http://localhost:8000'
	@echo '   make devserver [PORT=8000]       start/restart develop_server.sh    '
	@echo '   make ssh_upload                  upload the web site via SSH        '
	@echo '   make rsync_upload                upload the web site via rsync+ssh  '
	@echo '   make dropbox_upload              upload the web site via Dropbox    '
	@echo '   make ftp_upload                  upload the web site via FTP        '
	@echo '   make s3_upload                   upload the web site via S3         '
	@echo '   make cf_upload                   upload the web site via Cloud Files'
	@echo '   make github                      upload the web site via gh-pages   '
	@echo '                                                                       '
	@echo 'Set the DEBUG variable to 1 to enable debugging, e.g. make DEBUG=1 html'
	@echo '                                                                       '

html:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

cleanoutput:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)/{tag,author,20*,category,index*html,posts,feeds,files}

regenerate:
	$(PELICAN) -r $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

serve:
ifdef PORT
	$(PELICAN) -l $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) -p $(PORT)
else
	$(PELICAN) -l $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
endif

devserver:
ifdef PORT
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) -p $(PORT)
else
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
endif


publish: clean
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(PUBLISHCONF) $(PELICANOPTS)

ssh_upload: publish
	scp -C -P $(SSH_PORT) -r $(OUTPUTDIR)/* $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR)

rsync_upload: publish
	rsync -e "ssh -p $(SSH_PORT)" -P -rvz --delete $(OUTPUTDIR)/ $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR) --cvs-exclude

dropbox_upload: publish
	cp -r $(OUTPUTDIR)/* $(DROPBOX_DIR)

ftp_upload: publish
	lftp ftp://$(FTP_USER)@$(FTP_HOST) -p $(FTP_PORT) -e "set ftp:ssl-force on; set ftp:ssl-protect-data on; set ssl:verify-certificate no; mirror -R --delete --parallel=3 --ignore-time $(OUTPUTDIR) $(FTP_TARGET_DIR) ; quit"

s3_upload: publish
	s3cmd sync $(OUTPUTDIR)/ s3://$(S3_BUCKET) --acl-public --delete-removed

cf_upload: publish
	cd $(OUTPUTDIR) && swift -v -A https://auth.api.rackspacecloud.com/v1.0 -U $(CLOUDFILES_USERNAME) -K $(CLOUDFILES_API_KEY) upload -c $(CLOUDFILES_CONTAINER) .

github: publish
	ghp-import -m "Regenerate Pelican site" -b $(GITHUB_PAGES_BRANCH) -c "ankursinha.in" -n -p -f  "$(OUTPUTDIR)"


newpost:
ifdef NAME
	echo "$(NAME)" >  $(INPUTDIR)/$(DATEYYMMDD)-$(SLUG).$(EXT)
	echo -n "$(NAME)" | sed "s/./#/g" >>  $(INPUTDIR)/$(DATEYYMMDD)-$(SLUG).$(EXT)
	echo >>  $(INPUTDIR)/$(DATEYYMMDD)-$(SLUG).$(EXT)
	echo ":date: $(DATE)" >> $(INPUTDIR)/$(DATEYYMMDD)-$(SLUG).$(EXT)
	echo ":modified: $(DATE)" >> $(INPUTDIR)/$(DATEYYMMDD)-$(SLUG).$(EXT)
	echo ":author: $(AUTHOR)" >> $(INPUTDIR)/$(DATEYYMMDD)-$(SLUG).$(EXT)
	echo ":category: " >> $(INPUTDIR)/$(DATEYYMMDD)-$(SLUG).$(EXT)
	echo ":tags: " >> $(INPUTDIR)/$(DATEYYMMDD)-$(SLUG).$(EXT)
	echo ":slug: $(SLUG)" >> $(INPUTDIR)/$(DATEYYMMDD)-$(SLUG).$(EXT)
	echo ":status: draft" >> $(INPUTDIR)/$(DATEYYMMDD)-$(SLUG).$(EXT)
	echo ":summary: " >> $(INPUTDIR)/$(DATEYYMMDD)-$(SLUG).$(EXT)
	echo ""              >> $(INPUTDIR)/$(DATEYYMMDD)-$(SLUG).$(EXT)
	echo ""              >> $(INPUTDIR)/$(DATEYYMMDD)-$(SLUG).$(EXT)
	git add --intent-to-add $(INPUTDIR)/$(DATEYYMMDD)-$(SLUG).$(EXT)
	${EDITOR} ${INPUTDIR}/$(DATEYYMMDD)-${SLUG}.${EXT}
else
	@echo 'Variable NAME is not defined.'
	@echo 'Do make newpost NAME='"'"'Post Name'"'"
endif

editpost:
ifdef NAME
	${EDITOR} ${INPUTDIR}/$(DATEYYMMDD)-${SLUG}.${EXT}
else
	@echo 'Variable NAME is not defined.'
	@echo 'Do make editpost NAME='"'"'Post Name'"'"
endif

newpage:
ifdef NAME
	echo "$(NAME)" >  $(PAGESDIR)/$(SLUG).$(EXT)
	echo -n "$(NAME)" | sed "s/./#/g" >>  $(PAGESDIR)/$(SLUG).$(EXT)
	echo >> $(PAGESDIR)/$(SLUG).$(EXT)
	echo ":date: $(DATE)" >> $(PAGESDIR)/$(SLUG).$(EXT)
	echo ":author: $(AUTHOR)" >> $(PAGESDIR)/$(SLUG).$(EXT)
	echo ":slug: $(SLUG)" >> $(PAGESDIR)/$(SLUG).$(EXT)
	echo ""              >> $(PAGESDIR)/$(SLUG).$(EXT)
	echo ""              >> $(PAGESDIR)/$(SLUG).$(EXT)
	git add --intent-to-add $(PAGESDIR)/$(SLUG).$(EXT)
	${EDITOR} ${PAGESDIR}/${SLUG}.$(EXT)
else
	@echo 'Variable NAME is not defined.'
	@echo 'Do make newpage NAME='"'"'Page Name'"'"
endif

editpage:
ifdef NAME
	${EDITOR} ${PAGESDIR}/${SLUG}.$(EXT)
else
	@echo 'Variable NAME is not defined.'
	@echo 'Do make editpage NAME='"'"'Page Name'"'"
endif

listdrafts:
	grep -nrH "^:status:.* draft" $(INPUTDIR)/*rst | cut -d : -f 1 | sed 's|$(BASEDIR)/||'

.PHONY: html help clean regenerate serve devserver publish ssh_upload rsync_upload dropbox_upload ftp_upload s3_upload cf_upload github newpost newpage editpost editpage listdrafts
