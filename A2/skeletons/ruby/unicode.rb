class Unicode < Attack
  attr_reader :unicode_chars

  HTTP_PORT = 80                                                                # Port 80 indicates it was a HTTP request

  def initialize(args)
    super
    @unicode_chars = args[:unicode_chars]
  end

  def run(packet)
    return unless full_packet?(packet) && packet.tcp_header.body.length.nonzero? && packet.tcp_header.tcp_dst == HTTP_PORT # Only check the packet if it was a HTTP request
    url = packet.tcp_header.body.split("\n").first.downcase                     # The URL is the first part of the body up until a newline
    if @unicode_chars.any? { |chars| url.include? chars }
      @description = "src:#{packet.ip_saddr}, dst:#{packet.ip_daddr}"
      message
    end
  end
end
