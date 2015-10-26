def ip_packet?(packet)
  packet.methods.include? :ip_header
end

def tcp_packet?(packet)
  packet.methods.include? :tcp_flags
end

def full_packet?(packet)
  ip_packet?(packet) && tcp_packet?(packet)
end
