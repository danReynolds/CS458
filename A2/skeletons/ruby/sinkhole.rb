class Sinkhole
  attr_accessor :sinkholes

  def initialize(args)
    @sinkholes = []
    File.open(args[:sinkholes_path], "r") do |f|
      f.each_line do |line|
        @sinkholes.push line.chomp
      end
    end
  end

  def parse(bytes)
    if response
      total_questions = (bytes[4] << 4) + bytes[5]
      total_answers = (bytes[5] << 4) + bytes[6]
      ips = []

      qpos = 12                                                                   # Position where the first question starts past header info
      total_questions.times do
        qpos += bytes[qpos] + 1                                                   # Move past the question Domain Name
        qpos += bytes[qpos] + 1                                                   # Move past the question TLD
        qpos += 5                                                                 # Move past the QTYPE and QCLASS
      end
      anpos = qpos
      total_answers.times do
        anpos += 10                                                               # Move past the Answer's Name, TYPE, Class, TTL
        anLen = (bytes[anpos] << 4) + bytes[anpos + 1]
        anpos += 2                                                                # Move past the answer length check
        binding.pry
        ips << bytes[anpos..anpos + anLen - 1].join('.')
      end
    end
    return ips
  end

  def run(packet)
    bytes = packet.udp_header.body.each_byte.to_a
    response = (bytes[2] & 0b10000000) == 128                                   # Check if the dns message is a response or query
    return unless response

    ips = parse(bytes)

    ips.each do |ip|
      if @sinkholes.include? ip
        @description = "src:#{packet.ip_daddr}, host:#{}"
      end
    end
  end
end
