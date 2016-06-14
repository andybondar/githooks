#!/usr/bin/python2

rules_list="./regex_rules.list"
# Path to code you're gonna revise
#rootdir = "./joomla-cms"

import re
import os
import ConfigParser

Regexp = ConfigParser.ConfigParser()
Regexp.read(rules_list)

for root, subFolders, files in os.walk(rootdir):
	for file in files:
		scanned_file = os.path.join(root, file)
		line_number = 0
		with open(scanned_file, 'r') as f:
       			for line in f:
				line_number = line_number + 1
				for rule in Regexp.options('REGEXP'):
					regex = re.compile(Regexp.get('REGEXP', rule))
					if regex.match(line) != None:
						print str(rule).title() + " Detected in " + scanned_file
						print 'line ' + str(line_number) + ': ' + line
