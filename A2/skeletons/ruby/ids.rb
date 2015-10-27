#!/usr/bin/env ruby

require 'packetfu'
require 'pry'
require 'resolv'
require_relative 'attack'
require_relative 'anomaly'
require_relative 'spoof'
require_relative 'server'
require_relative 'sinkhole'
require_relative 'arp'
require_relative 'unicode'
require_relative 'ddos'

include PacketFu

# The CIDR format 10.0.0.0/8 translates to the range 10.0.0.0 to 10.255.255.0
MIN_ADDRESS = 167772160.freeze                                                  # min IP of 10.0.0.0 to decimal
MAX_ADDRESS = 184549375.freeze                                                  # max IP of 10.255.255.0 to decimal
PATH = ARGV[0]
exit if PATH.nil?

args = {
  min_addr: MIN_ADDRESS,
  max_addr: MAX_ADDRESS
}

anomaly = Anomaly.new(args)
spoof = Spoof.new(args.merge!({ type: 'Spoofed IP address' }))
server = Server.new(args.merge!({
    attempted_type: 'Attempted server connection',
    accepted_type: 'Accepted server connection'
}))
sinkhole = Sinkhole.new(args.merge!({
  type: 'Sinkhole lookup',
  sinkholes_path: 'sinkholes.txt'
}))
arp = Arp.new(args.merge!({
  type: 'Potential ARP spoofing'
}))
unicode = Unicode.new(args.merge!({
    type: 'Unicode IIS exploit',
    unicode_chars: [
      '%255c',
      '%%35c',
      '%%35%63',
      '%25%35%63',
      '%5c',
      '%2f',
      '%252f',
      '%c1%1c',
      '%c0%af',
      '%c1%af',
      '%c1%9c',
      '%e0%80%af',
      '%e0\%80\%af',
      '%f0%80%80%af',
      '%f8%80%80%80%af',
      '%fc%80%80%80%80%af',
      '%fc%80%80%80%af'
    ]
}))
ddos = DDOS.new(args.merge!({
    type: 'NTP DDoS'
}))

packets = PcapFile.read_packets(PATH)
packets.each do |packet|
  spoof.run(packet)
  server.run(packet)
  sinkhole.run(packet)
  anomaly.run(packet)
  arp.run(packet)
  unicode.run(packet)
  ddos.run(packet)
end
anomaly.message
