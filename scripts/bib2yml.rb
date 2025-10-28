#!/usr/bin/env ruby
require 'bibtex'
require 'yaml'

if ARGV.length != 2
  puts "Usage: ruby bib2yml.rb input.bib output.yml"
  exit
end

input_file = ARGV[0]
output_file = ARGV[1]

bib = BibTeX.open(input_file)
bib = bib.sort_by { |entry| entry[:year].to_i }.reverse

yaml_array = bib.map do |entry|
  entry.to_h.reject { |k,_| k == :id }.merge({
    'id' => entry.key.to_s
  })
end

File.open(output_file, 'w') { |f| f.write(yaml_array.to_yaml) }

puts "Converted #{input_file} to #{output_file}"
