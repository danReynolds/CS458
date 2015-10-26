class Anomaly < Attack
  attr_accessor :packets, :bytes

  def initialize(args)
    @bytes = 0
    @packets = 0
  end

  def run(packet)
    @packets += 1
    @bytes += packet.length
  end

  def message
    puts "Analyzed #{@packets} packets, #{@bytes} bytes"
  end
end
