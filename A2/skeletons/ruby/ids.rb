#!/usr/bin/env ruby

require 'packetfu'
require 'pry'
require_relative 'attack'
require_relative 'anomaly'
require_relative 'spoof'
require_relative 'server'

include PacketFu

unless ARGV.length == 1
  puts "Invalid arguments"
  return
end

# The CIDR format 10.0.0.0/8 translates to the range 10.0.0.0 to 10.255.255.0
MIN_ADDRESS = 167772160.freeze                                                  # min IP of 10.0.0.0 to decimal
MAX_ADDRESS = 184549375.freeze                                                  # max IP of 10.255.255.0 to decimal

args = {
  path: ARGV[0],
  min_addr: MIN_ADDRESS,
  max_addr: MAX_ADDRESS
}

spoof = Spoof.new(args.merge!({ type: "Spoofed IP address" }))
spoof.run

server = Server.new(args.merge!({
    attempted_type: "Attempted server connection",
    accepted_type: "Accepted server connection"
}))
server.run

anomaly = Anomaly.new(args)
anomaly.run
