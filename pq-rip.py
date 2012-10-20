#!/usr/bin/env python

from pyquery import PyQuery as pq
import re
import sys
import getopt
from urlparse import urljoin

opts, args = getopt.getopt(sys.argv[1:], "ura:s:")

need_url = False
need_reverse = False
need_attribute = False
need_stdin = False

for o, a in opts:
	if o == "-u":
		need_url = True
	if o == "-r":
		need_reverse = True
	if o == "-a":
		need_attribute = a
	if o == "-s":
		need_stdin = a

if need_stdin:
	url = sys.stdin.read()
	selector = args[0]
else:
	url = args[0]
	selector = args[1]


doc = pq(url)

result = []

def cb(idx, node):
	if need_attribute:
		txt = pq(node).attr(need_attribute)
	else:
		txt = pq(node).text().encode('utf-8')
		txt = re.sub(r'[\r\n]', '', txt)
		if need_url:
			href = pq(node).attr('href')
			if href:
				href = urljoin(url, href)
				txt = href + "|" + txt
			elif need_stdin:
				txt = need_stdin + "|" + txt
			else:
				txt = url + "|" + txt
	result.append(txt)

items = doc(selector)

items.each(cb)

if need_reverse:
	items.reverse()

for t in result:
	print t
