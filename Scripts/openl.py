#!/usr/bin/env python
import os
import sys

def toInt(x):
	try:
		x = int(x)
	except ValueError:
		x = -1
	return x

if (len(sys.argv) > 1):
	try:
		print sys.argv[1]
		std = open(sys.argv[1])
	except:
		print "File not found"
else:
	std=sys.stdin


file = std.readlines()
lines = []
sys.stdin=open("/dev/tty")
n = 1

for line in file:
	line = line.rstrip('\n')
	if (os.path.exists(line)):
		if (n == 1):
			print "[0]\tcancel\n[1]	all"
		n += 1
		print "[%i]\t%s" % (n, line)
		lines.append(line)
if not(len(lines)):
	print "No files"
	exit(1)

x = toInt(raw_input("Which file(s) to open?: "))

while True:
	if (x >= 0 and x <= n):
		if (x == 0):
			break
		elif (x == 1):
			for i in range(0, n - 1):
				os.system("open \"%s\"" % lines[i])
			break
		else:
			os.system("open \"%s\"" % lines[x - 2])
			break
	else:
		x = toInt(raw_input("Please enter values in the range 0 through %i: " % n))
