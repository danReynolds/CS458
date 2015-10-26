blackbox_path = "/home/dan/coding/school/CS458/A2/samples/"
blackbox_log_files = [
  "q1-anomaly-output.log",
  "q2-spoofed-output.log",
  "q3-servers-output.log"
]

blackbox_test_files = [
  "q1-anomaly.pcap",
  "q2-spoofed.pcap",
  "q3-servers.pcap"
]

output_files = [
  "outputs/anomaly.txt",
  "outputs/spoof.txt",
  "outputs/server.txt"
]

blackbox_test_files.length.times do |i|
  %x[./ids.rb #{blackbox_path}#{blackbox_test_files[i]} > #{output_files[i]}]
end

blackbox_log_files.length.times do |i|
  diff = %x[diff -q #{blackbox_path}#{blackbox_log_files[i]} #{output_files[i]}]
  puts %x[diff -y #{blackbox_path}#{blackbox_log_files[i]} #{output_files[i]}] if diff.strip.length.nonzero?
end