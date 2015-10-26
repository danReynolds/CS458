class Anomaly < Attack
  attr_accessor :packets, :bytes

  def initialize(args)
    super
    @bytes = 0
  end

  def run
    @packets = PcapFile.read_packet_bytes(path) { |p| @bytes += p.length }
    message
  end

  def message
    puts "Analyzed #{@packets} packets, #{@bytes} bytes"
  end
end
