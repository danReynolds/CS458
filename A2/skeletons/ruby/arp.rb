class Arp < Attack
  attr_accessor :addresses

  def initialize(args)
    super
    @addresses = {}
  end

  def run(packet)
    return unless arp_packet?(packet) && packet.arp_opcode == 2
    arp_reply = packet.arp_header.arp_src_mac_readable.upcase
    ip_reply = packet.arp_saddr_ip
    if @addresses[ip_reply] && @addresses[ip_reply] != arp_reply
      @description = "ip:#{ip_reply}, old:#{addresses[ip_reply]}, new:#{arp_reply}"
      message
    end
    @addresses[ip_reply] = arp_reply
  end
end
