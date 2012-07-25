#!/usr/bin/env python

from pyquery import PyQuery as pq
import re
import sys
import getopt

opts, args = getopt.getopt(sys.argv[1:], "u")

if len(args) < 2:
	raise Exception('Arguments not enough')

need_url = False

for o, a in opts:
	if o == "-u":
		need_url = True

url = args[0]
selector = args[1]

doc = pq(url)

result = []

def cb(idx, node):
	txt = pq(node).text().encode('utf-8')
	result.append(txt)

items = doc(selector)

items.each(cb)

for t in result:
	if need_url:
		print url + "|" + re.sub(r'[\r\n]', ' ', t)
	else:
		print re.sub(r'[\r\n]', ' ', t)

