class Spoof < Attack
  def run(packet)
    return unless ip_packet?(packet) && external?(packet.ip_src) && external?(packet.ip_dst)
    @description = "src:#{packet.ip_saddr}, dst:#{packet.ip_daddr}"
    message
  end
end
