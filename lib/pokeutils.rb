require 'net/http'
require 'json'

module PokeUtilities

  
  def self.poke_endpoint nationalno
    #daily rate limit of 300 requests per resource per IP address..
    "http://pokeapi.co/api/v2/pokemon/#{nationalno}/"
  end

  def self.name_from nationalno
    puts "Getting pokemon name for #{nationalno} via pokeapi.co"
    url = poke_endpoint nationalno
    response = Net::HTTP.get URI(url)
    json = JSON.parse response
    json['name']
  end

end