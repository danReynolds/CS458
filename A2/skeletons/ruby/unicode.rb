class Unicode < Attack
  attr_reader :unicode_chars

  HTTP_PORT = 80

  def initialize(args)
    super
    @unicode_chars = args[:unicode_chars]
  end

  def run(packet)
    return unless full_packet?(packet) && packet.tcp_header.tcp_dst == HTTP_PORT

    if @unicode_chars.any? { |chars| packet.tcp_header.body.downcase.include? chars }
      @description = "src:#{packet.ip_saddr}, dst:#{packet.ip_daddr}"
      message
    end
  end
end
