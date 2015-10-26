class Sinkhole
  attr_accessor :sinkholes

  def initialize(args)
    @sinkholes = []
    File.open(args[:sinkholes_path], "r") do |f|
      f.each_line do |line|
        sinkholes.push line.chomp
      end
    end
  end

  def run
  end
end
