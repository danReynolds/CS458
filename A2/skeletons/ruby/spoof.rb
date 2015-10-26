class Spoof < Attack
  def run
    packets = PcapFile.read_packets(path)
    invalid_packets = packets.select { |packet| full_packet?(packet) && external?(packet.ip_src) && external?(packet.ip_dst) }

    invalid_packets.each do |packet|
      @description = "src:#{packet.ip_saddr}, dst:#{packet.ip_daddr}"
      message
    end
  end
end
