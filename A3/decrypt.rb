require 'net/http'
require 'base64'

HTTP_OK    = "200"
HTTP_ERROR = "500"
BLOCK_SIZE = 16
BYTE_RANGE = (0..255).to_a
blocks = Base64.decode64(ARGV[0]).bytes.each_slice(16).map(&:to_a)

def send_request(cookie)
  url = "http://localhost:4555"
  uri = URI(url)
  http = Net::HTTP.new(uri.host, 4555)
  request = Net::HTTP::Get.new(uri.request_uri)
  request['Cookie'] = "user=#{cookie}"
  http.request(request)
end

def find_offset(test_block, decrypt_block, pos)
  (BYTE_RANGE).detect do |v|
    test_block[pos] = v
    guess = Base64.encode64((test_block + decrypt_block).pack('c*'))
    res = send_request(guess)
    res.code == HTTP_OK
  end
end

def calculate_padding(test_block, decrypt_block)
  BLOCK_SIZE - BLOCK_SIZE.times.detect do |i|
    test_block[i] ^= 1
    guess = Base64.encode64((test_block + decrypt_block).pack('c*'))
    res = send_request(guess)
    res.code == HTTP_ERROR
  end
end

def decode_block(decrypt_block, cipher_block)
  hack_block = BYTE_RANGE.shuffle.first(16)
  encoded_bytes = Array.new(BLOCK_SIZE, 0)
  padding_length = 0

  decrypt_block.reverse.each_with_index do |byte, index|
    pos = BLOCK_SIZE - index - 1
    if index.zero?
      hack_block[pos] = find_offset(hack_block.dup, decrypt_block, pos)
      padding_length = calculate_padding(hack_block.dup, decrypt_block)
      puts padding_length
      encoded_bytes[pos] = hack_block[pos] ^ padding_length
    elsif index < padding_length - 1
      encoded_bytes[pos] = hack_block[pos]
    else
      hack_block[BLOCK_SIZE - 1] = encoded_bytes.last ^ (index + 1)
      encoded_bytes[pos] = hack_block[pos] = find_offset(hack_block.dup, decrypt_block, pos)
    end
  end

  cipher_block.zip(encoded_bytes).map do |cipher_byte, encoded_byte|
    puts cipher_byte ^ encoded_byte
    cipher_byte ^ encoded_byte
  end.pack("c*")
end

decrypted_message = (blocks.length - 1).times.inject("") do |acc, i|
  a = decode_block(blocks.pop, blocks.last)
  puts a.bytes.map(&:to_a).join(",")
  a + acc
end

puts decrypted_message.bytes.map(&:to_a).join(",")
puts decrypted_message
