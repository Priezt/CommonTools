#!/usr/bin/env phantomjs

var system = require('system');
var url = system.args[1];

var page = require('webpage').create();
page.open(url, function(){
	console.log(page.content);
	phantom.exit();
});

