#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

# This file is only used if you use `make publish` or
# explicitly specify it as your config file.

import os
import sys
sys.path.append(os.curdir)
from pelicanconf import *

SITEURL = 'https://ankursinha.in'

FEED_DOMAIN = SITEURL
FEED_ALL_ATOM = 'feeds/all.atom.xml'
FEED_ALL_RSS = 'feeds/all.rss.xml'
CATEGORY_FEED_ATOM = 'feeds/categories/{slug}.atom.xml'
CATEGORY_FEED_RSS = 'feeds/categories/{slug}.rss.xml'
TAG_FEED_ATOM = 'feeds/tags/{slug}.atom.xml'
TAG_FEED_RSS = 'feeds/tags/{slug}.rss.xml'
AUTHOR_FEED_ATOM = 'feeds/authors/{slug}.atom.xml'
AUTHOR_FEED_RSS = 'feeds/authors/{slug}.rss.xml'
FEED_MAX_ITEMS = 10

DELETE_OUTPUT_DIRECTORY = False

DISQUS_SITENAME = u'ankursinha'
ANALYTICS = """
    <!-- Google tag (gtag.js) -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-MCTH8VNYDK"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());

      gtag('config', 'G-MCTH8VNYDK');
    </script>
"""
