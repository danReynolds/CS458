class DDOS < Attack
  MON_GETLIST_1 = 42

  def run(packet)
    return unless udp_packet?(packet)

    bytes = packet.udp_header.body.each_byte.to_a
    request_type = bytes[3]                                                     # The fourth byte contains the request code for the operation to be performed
    if request_type == MON_GETLIST_1
      @description = "vic:#{packet.ip_header.ip_saddr}, srv:#{packet.ip_header.ip_daddr}"
      message
    end
  end
end
