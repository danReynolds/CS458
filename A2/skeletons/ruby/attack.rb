class Attack
  attr_accessor :type, :description, :addresses

  def initialize(args)
    @type = args[:type]
    @addresses = (args[:min_addr]..args[:max_addr])
  end

  def message
    puts "[#{@type}]: #{@description}"
  end

  def external?(address)
    !(@addresses.include? address)
  end

  def internal?(address)
    @addresses.include? address
  end
end
