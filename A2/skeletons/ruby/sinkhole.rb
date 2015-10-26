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

    answers = payload.answer

    answers.each do |answer|
      break unless answer.last.class == Resolv::DNS::Resource::IN::A
      address = answer.last.address.to_s
      if @sinkholes.include? address
        @description = "src:#{packet.ip_daddr}, host:#{answer.first.to_s}, ip:#{address}"
        message
      end
    end
  end
end
