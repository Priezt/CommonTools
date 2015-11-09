#!/usr/bin/env phantomjs

var system = require('system');
if(system.args.length < 2){
	console.log('need url');
	phantom.exit();
}
var page = require('webpage').create();
var url = system.args[1]
page.open(url, function(status){
	console.log(page.evaluate(function(){
		return document.getElementByTagName('html')[0].innerHTML;
	}));
	phantom.exit()
});
