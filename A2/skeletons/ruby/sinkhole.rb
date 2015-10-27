class Sinkhole < Attack
  attr_accessor :sinkholes

  def initialize(args)
    super
    @sinkholes = []
    File.open(args[:sinkholes_path], "r") do |f|
      f.each_line do |line|
        @sinkholes.push line.chomp
      end
    end
  end

  def run(packet)
    return unless udp_packet?(packet)

    begin
      payload = Resolv::DNS::Message.decode(packet.udp_header.body)
    rescue  Resolv::DNS::DecodeError
      return
    end

    payload.answer.select do |answer|
      answer.last.class == Resolv::DNS::Resource::IN::A && @sinkholes.include?(answer.last.address.to_s)
    end.each do |sinkhole_answer|
      @description = "src:#{packet.ip_daddr}, host:#{sinkhole_answer.first.to_s}, ip:#{sinkhole_answer.last.address.to_s}"
      message
    end
  end
end
