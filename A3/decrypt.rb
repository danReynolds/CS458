require 'net/http'
require 'base64'

HTTP_OK = "200"
BLOCK_SIZE = 16
blocks = Base64.decode64(ARGV[0]).bytes.each_slice(16).map(&:to_a)

def send_request(cookie)
  url = "http://localhost:4555"
  uri = URI(url)
  http = Net::HTTP.new(uri.host, 4555)
  request = Net::HTTP::Get.new(uri.request_uri)
  request['Cookie'] = "user=#{cookie}"
  http.request(request)
end

def decode_block(decrypt_block, cipher_block, padding)
  hack_block = Array.new(BLOCK_SIZE, 0)
  encoded_bytes = Array.new(BLOCK_SIZE, 0)

  decrypt_block.reverse.each_with_index do |byte, index|
    hack_block[BLOCK_SIZE - 1] = encoded_bytes.last ^ (index + 1)
    encoded_bytes[BLOCK_SIZE - index - 1] = (0..255).to_a.detect do |v|
      hack_block[BLOCK_SIZE - index - 1] = v
      guess = Base64.encode64((hack_block + decrypt_block).pack('c*'))
      res = send_request(guess)
      res.code == HTTP_OK
    end
    encoded_bytes[BLOCK_SIZE - 1] ^= 1 if index.zero?
  end

  cipher_block.zip(encoded_bytes).map do |cipher_byte, encoded_byte|
    cipher_byte ^ encoded_byte
  end.pack("c*")
end

decrypted_message = (blocks.length - 1).times.inject("") do |acc, i|
  decode_block(blocks.pop, blocks.last, i == 0) + acc
end[0..-2]

puts decrypted_message
