require 'active_support/core_ext/hash'
require 'rspec'
require 'rexml/document'
require 'net/http'
require 'pp'

def macbeth_counter
  url = 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml'
  xmlPlay = Net::HTTP.get_response(URI.parse(url)).body
  hash = Hash.from_xml(xmlPlay)

  counter_hash = Hash.new{ |h, key| h[key] = 0}
  hash['PLAY']['ACT'].each do |key, value|
    key['SCENE'].each do |key2, value2|
      key2['SPEECH'].each do |key3, value3|
        counter_hash[key3['SPEAKER']] += Array(key3['LINE']).count
      end
    end
  end
  counter_hash
end
pp macbeth_counter
