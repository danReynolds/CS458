class Attack
  attr_reader :type, :description, :addresses

  def initialize(args)
    @type = args[:type]
    @addresses = (args[:min_addr]..args[:max_addr])
  end

  def message
    puts "[#{@type}]: #{@description}"
  end

  def external?(address)
    !(@addresses.include? address)
  end

  def internal?(address)
    @addresses.include? address
  end

  def ip_packet?(packet)
    packet.methods.include? :ip_header
  end

  def udp_packet?(packet)
    packet.methods.include? :udp_header
  end

  def tcp_packet?(packet)
    packet.methods.include? :tcp_flags
  end

  def full_packet?(packet)
    ip_packet?(packet) && tcp_packet?(packet)
  end

  def arp_packet?(packet)
    packet.methods.include? :arp_header
  end
end
