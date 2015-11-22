# Based on http://www.jonathanleighton.com/articles/2011/awesome-active-record-bug-reports/

# Run this script with `$ ruby my_script.rb`
require 'sqlite3'
require 'active_record'

# Use `binding.pry` anywhere in this script for easy debugging
require 'pry'

# Connect to an in-memory sqlite3 database
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Define a minimal database schema
ActiveRecord::Schema.define do
  create_table :ciphertexts, force: true do |t|
    t.string :name
    t.string :text
  end
end

# Define the models
class Ciphertext < ActiveRecord::Base
end

Ciphertext.create!({name: "A", text: " " * 300})
Ciphertext.create!({name: "B", text: " " * 300})
Ciphertext.all.each { |e| puts e.name }
