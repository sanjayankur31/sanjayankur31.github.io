# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Ankur Sinha'
SITENAME = u'ankursinha.in/blog'
SITESUBTITLE = u'neuroscience/fedora/musings'
SITETAG = u'neuroscience/fedora/musings'
TWITTER_USERNAME = 'sanjay_ankur'
TWITTER_CARD = True

FONT_AWESOME_CDN_LINK = {}
JAVASCRIPT_URLS = ['https://kit.fontawesome.com/9f8622f8d1.js']

STATIC_PATHS = ['images', 'extras/favicon.ico',
                'extras/feeds-allow-indexing',
                'extras/drafts-allow-indexing',
                'extras/redirect-blog',
                'extras/AnkurSinha-resume.pdf',
                'extras/Sinha2020b - Structural Plasticity and Associative Memory in Balanced Neural Networks with Spike Time Dependent Inhibitory Plasticity.pdf']
EXTRA_PATH_METADATA = {
    'extras/favicon.ico': {'path': 'favicon.ico'},
    'extras/feeds-allow-indexing': {'path': 'feeds/.htaccess'},
    'extras/drafts-allow-indexing': {'path': 'drafts/.htaccess'},
    'extras/redirect-blog': {'path': 'blog/index.html'},
    'extras/AnkurSinha-resume.pdf': {'path': 'files/AnkurSinha-resume.pdf'},
    'extras/Sinha2020b - Structural Plasticity and Associative Memory in Balanced Neural Networks with Spike Time Dependent Inhibitory Plasticity.pdf': {'path': 'files/Sinha2020b - Structural Plasticity and Associative Memory in Balanced Neural Networks with Spike Time Dependent Inhibitory Plasticity.pdf'},
}
ARTICLE_PATHS = ['']
ARTICLE_SAVE_AS = '{date:%Y}/{date:%m}/{date:%d}/{slug}.html'
ARTICLE_URL = '{date:%Y}/{date:%m}/{date:%d}/{slug}.html'

ARCHIVES_SAVE_AS = 'pages/archives.html'
YEAR_ARCHIVE_SAVE_AS = 'posts/{date:%Y}/index.html'
MONTH_ARCHIVE_SAVE_AS = 'posts/{date:%Y}/{date:%m}/index.html'

TAG_URL = 'tag/{slug}/'
TAG_SAVE_AS = 'tag/{slug}/index.html'
CATEGORY_URL = 'category/{slug}/'
CATEGORY_SAVE_AS = 'category/{slug}/index.html'

SIDEBAR = 'sidebar.html'
CUSTOM_SIDEBAR_MIDDLES = ("sb_links.html", "sb_tagcloud.html")

TIMEZONE = 'Europe/London'

DEFAULT_LANG = u'en'

THEME = 'voidy-bootstrap'

PLUGIN_PATHS = ['pelican-plugins', 'pelican-plugins-other']
# RESPONSIVE_IMAGES = False
PLUGINS = ['pelican.plugins.share_post', 'post_stats', 'render_math', 'sitemap', 'tag_cloud', 'series',
           'pelican-cite', 'pelican-bibtex']
# 'series', 'pelican-cite', 'pelican-bibtex', 'events']

TAG_CLOUD_STEPS = 4
TAG_CLOUD_MAX_ITEMS = 30
TAG_CLOUD_SORTING = 'random'


# Blogroll
LINKS = (
    ('NeuroFedora',
     'https://neuro.fedoraproject.org'),
    ('Fedora Project', 'http://fedoraproject.org'),
    ('INCF',
     'https://www.incf.org'),
    ('OCNS', 'https://ocns.memberclicks.net/'),
    ('INCF/OCNS Software WG',
     'https://ocns.github.io/SoftwareWG/'),
    ('TeX Users Group',
     'http://tug.org/'),
    ('Comp Neuro on the Web',
     'http://home.earthlink.net/~perlewitz/index.html'),
    ('Neuroscience feeds',
     'https://neuroblog.fedoraproject.org/planet-neuroscience/'),
    ('Neuroscientists feeds',
     'https://neuroblog.fedoraproject.org/planet-neuroscientists/'),
    ('My neuroscience list on Twitter',
     'https://twitter.com/sanjay_ankur/lists/neuroscience'),
    ('Open Neuroscience',
     'https://open-neuroscience.com/'),
)

# Social widget
SOCIAL = (
    ('Search (DuckDuckGo)',
     'https://duckduckgo.com/?q=site%3Aankursinha.in&ia=web',
     'fas fa-search fa-fw fa-lg'),
    ('Scholar',
     'http://scholar.google.co.in/citations?user=919ScZEAAAAJ&hl=en',
     'fas fa-graduation-cap fa-fw fa-lg'),
    ('GitHub', 'http://github.com/sanjayankur31',
     'fab fa-github fa-fw fa-lg'),
    ('Orcid', ' https://orcid.org/0000-0001-7568-7167',
     'fas fa-flask fa-fw fa-lg'),
    ('Fedora',
     'https://fedoraproject.org/wiki/User:Ankursinha',
     'fab fa-fedora fa-fw fa-lg'),
    ('BookWyrm', 'https://ramblingreaders.org/user/sanjay_ankur',
     'fas fa-book-reader fa-fw fa-lg'),
    ('Mastodon', 'https://fosstodon.org/@sanjay_ankur',
     'fab fa-mastodon fa-fw fa-lg'),
    ('Goodreads', 'https://www.goodreads.com/user/show/32360473-ankur',
     'fab fa-goodreads-g fa-fw fa-lg'),
    ('Twitter', 'https://twitter.com/sanjay_ankur',
     'fab fa-twitter fa-fw fa-lg'),
    ('NeuroTree', 'https://neurotree.org/neurotree/tree.php?pid=96687',
     'fas fa-brain fa-fw fa-lg'),
    ('Last.fm', 'http://www.last.fm/user/sanjay_ankur',
     'fab fa-lastfm fa-fw fa-lg'),
    #  ('Facebook', 'http://www.facebook.com/sanjay.ankur',
    #  'fa fa-facebook-square fa-fw fa-lg'),
    #  ('Instagram', 'https://instagram.com/sanjay.ankur/',
    #  'fa fa-instagram fa-fw fa-lg'),
    # ('Flickr', 'https://www.flickr.com/people/30402562@N07/',
    #  'fa fa-flickr fa-fw fa-lg'),
    # ('Foursquare', 'https://foursquare.com/sanjay_ankur/',
    #  'fa fa-foursquare fa-fw fa-lg'),
)

DEFAULT_PAGINATION = 10
DELETE_OUTPUT_DIRECTORY = False

SITEMAP = {
    'format': 'xml',
    'priorities': {
        'articles': 0.5,
        'indexes': 0.5,
        'pages': 0.5
    },
    'changefreqs': {
        'articles': 'monthly',
        'indexes': 'daily',
        'pages': 'monthly'
    }
}

CUSTOM_ARTICLE_PRECONTENT = 'sharing.html'
CUSTOM_ARTICLE_FOOTERS = ('sharing.html',)
CUSTOM_SCRIPTS_ARTICLE = "sharing_scripts.html"
MATH_JAX = {'tex_extensions': ['color.js', 'mhchem.js'], 'color': 'blue', 'align': 'left'}
STYLESHEET_FILES = ("use-opensans.css", "voidybootstrap.css", "pygment.css")
RELATIVE_URLS = False
CACHE_CONTENT = True

# PLUGIN_EVENTS = {
#   'ics_fname': 'ankursinha.ics',
# }

MY_PUBLICATIONS_SRC = 'content/mypubs.bib'
DIRECT_TEMPLATES = ['index', 'archives', 'categories', 'tags', 'publications']
PUBLICATIONS_SAVE_AS = 'pages/03-publications.html'

# DIRECT_TEMPLATES = (('publications'))
