class Arp < Attack
  attr_reader :addresses

  OP_REPLY = 2                                                                  # An Arp Operation Code of 2 indicates a REPLY

  def initialize(args)
    super
    @addresses = {}
  end

  def run(packet)
    return unless arp_packet?(packet) && packet.arp_opcode == OP_REPLY
    arp_reply = packet.arp_header.arp_src_mac_readable.upcase
    ip_reply = packet.arp_saddr_ip
    if @addresses[ip_reply] && @addresses[ip_reply] != arp_reply
      @description = "ip:#{ip_reply}, old:#{addresses[ip_reply]}, new:#{arp_reply}"
      message
    end
    @addresses[ip_reply] = arp_reply
  end
end
