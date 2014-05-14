#!/usr/bin/env python

import sys
import datetime
import PyRSS2Gen
import os
import re
import getopt
import os.path

opts, args = getopt.getopt(sys.argv[1:], "")

if len(args) < 1:
	raise Exception('Arguments not enough')
name = args[0]

path = os.environ['HOME'] + "/" + '.rss/' + name
if not os.path.exists(path):
	os.system('mkdir -p ' + path)

max_id = 0

dirList = os.listdir(path)
dirList.sort()
if len(dirList) > 0:
	m = re.search(r'\b(\d{8})$', dirList[-1])
	if m:
		max_id = int(m.group(1))

for line in sys.stdin:
	line = line.rstrip()
	parts = line.split('|', 1)
	url = parts[0]
	content = parts[1]
	ri = {
		'title' : name + ": " + content,
		'link' : url,
		'description' : content,
		'guid' : repr(parts),
		'pubDate' : datetime.datetime.utcnow()
	}
	max_id += 1
	open('%s/%08d' % (path, max_id), 'w').write(repr(ri))

dirList = os.listdir(path)
dirList.sort()
dirList.reverse()

latest = dirList[0:30]

latest.reverse()

rssitems = []
for f in latest:
	_ri = eval(open(path + '/' + f).read())
	_ri['guid'] = PyRSS2Gen.Guid(_ri['guid'])
	ri = PyRSS2Gen.RSSItem(**_ri)
	rssitems.append(ri)

rss = PyRSS2Gen.RSS2(
	title = name,
	link = 'http://priezt.me/rss',
	description = name,
	lastBuildDate = datetime.datetime.utcnow(),
	items = rssitems
)

print rss.to_xml(encoding='UTF-8')

