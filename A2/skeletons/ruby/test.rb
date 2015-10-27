blackbox_path = "/home/dan/coding/school/CS458/A2/samples/"
blackbox_log_files = [
  "q1-anomaly-output.log",
  "q2-spoofed-output.log",
  "q3-servers-output.log",
  "q4-sinkholes-output.log",
  "q5-arp-output.log",
  "q6-unicode-output.log",
  "q7-ntp-output.log"
]

blackbox_test_files = [
  "q1-anomaly.pcap",
  "q2-spoofed.pcap",
  "q3-servers.pcap",
  "q4-sinkholes.pcap",
  "q5-arp.pcap",
  "q6-unicode.pcap",
  "q7-ntp.pcap"
]

output_files = [
  "outputs/anomaly.txt",
  "outputs/spoof.txt",
  "outputs/server.txt",
  "outputs/sinkhole.txt",
  "outputs/arp.txt",
  "outputs/unicode.txt",
  "outputs/ntp.txt"
]

blackbox_test_files.length.times do |i|
  %x[./ids.rb #{blackbox_path}#{blackbox_test_files[i]} > #{output_files[i]}]
end

blackbox_log_files.length.times do |i|
  diff = %x[diff -q #{blackbox_path}#{blackbox_log_files[i]} #{output_files[i]}]
  puts %x[diff -y #{blackbox_path}#{blackbox_log_files[i]} #{output_files[i]}] if diff.strip.length.nonzero?
end
