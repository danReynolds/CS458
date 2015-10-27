class Server < Attack
  attr_reader :attempted_type, :accepted_type

  def initialize(args)
    super
    @attempted_type = args[:attempted_type]
    @accepted_type = args[:accepted_type]
  end

  def run(packet)
    return unless full_packet?(packet)

    if external?(packet.ip_src)
      if internal?(packet.ip_dst) && packet.tcp_flags.syn == 1 && packet.tcp_flags.ack == 0
        @type = @attempted_type
        @description = "rem:#{packet.ip_saddr}, srv:#{packet.ip_daddr}, port:#{packet.tcp_dst}"
        message
      end
    elsif external?(packet.ip_dst) && packet.tcp_flags.syn == 1 && packet.tcp_flags.ack == 1
      @type = @accepted_type
      @description = "rem:#{packet.ip_daddr}, srv:#{packet.ip_saddr}, port:#{packet.tcp_src}"
      message
    end
  end
end
