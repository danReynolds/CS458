# Programming Bonus

1. The attacker could send a packet spoofed to have a source IP of one of the other machines on the LAN. The sinkhole detector would then claim that the source of the DNS query was that machine on the LAN, framing the machine.

2. An insertion attack uses the fact that an IDS may accept certain things that the actual system will not allow. A web request could be invalid, for example, to the actual system, but in terms of what our IDS sees, it will just look at a HTTP request and analyze the URL for potentially dangerous unicode encodings.

A worm could avoid detection by our IDS by making a request for a URL that would be modified by the actual system because it is invalid, but not modified by the IDS. If the string contained an invalid character that the system would strip out, but that our IDS would not, then the IDS will include the character and not pattern match a dangerous unicode character, while the actual system will strip it out and process the unicode encoding as a `\` or `/` or any other character that could result in a unicode directory traversal exploit.
