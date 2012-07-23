#!/usr/bin/env python

from pyquery import PyQuery as pq
import re
import sys

if len(sys.argv) < 3:
	raise Exception('Arguments not enough')

url = sys.argv[1]
selector = sys.argv[2]

doc = pq(url)

result = []

def cb(idx, node):
	txt = pq(node).text().encode('utf-8')
	result.append(txt)

items = doc(selector)

items.each(cb)

for t in result:
	print re.sub(r'[\r\n]', ' ', t)

