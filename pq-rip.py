#!/usr/bin/env python

from pyquery import PyQuery as pq
import re
import sys
import getopt
from urlparse import urljoin

opts, args = getopt.getopt(sys.argv[1:], "ur")

if len(args) < 2:
	raise Exception('Arguments not enough')

need_url = False
need_reverse = False

for o, a in opts:
	if o == "-u":
		need_url = True
	if o == "-r":
		need_reverse = True

url = args[0]
selector = args[1]

doc = pq(url)

result = []

def cb(idx, node):
	txt = pq(node).text().encode('utf-8')
	txt = re.sub(r'[\r\n]', '', txt)
	if need_url:
		href = pq(node).attr('href')
		if href:
			href = urljoin(url, href)
			txt = href + "|" + txt
		else:
			txt = url + "|" + txt
	result.append(txt)

items = doc(selector)

items.each(cb)

if need_reverse:
	items.reverse()

for t in result:
	print t
