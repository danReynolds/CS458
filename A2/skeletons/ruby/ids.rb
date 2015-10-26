#!/usr/bin/env ruby

require 'packetfu'
require 'pry'
require_relative 'attack'
require_relative 'anomaly'
require_relative 'spoof'
require_relative 'server'
require_relative 'sinkhole'
require_relative 'helpers'

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

packets = PcapFile.read_packets(PATH)
packets.each do |packet|
  if full_packet?(packet)
    spoof.run(packet)
    server.run(packet)
  end
  sinkhole.run(packet)
  anomaly.run(packet)
end
anomaly.message
