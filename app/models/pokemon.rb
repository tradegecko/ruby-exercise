require 'net/http'
require 'json'
require 'open-uri'

class Pokemon < ActiveRecord::Base
  
  MAX_NO_OF_POKEMONS=720

  validates :nationalno,
              presence: true,
              uniqueness: true,
              inclusion: { 
                in: 1..MAX_NO_OF_POKEMONS,
                message: "must be between 1 and #{MAX_NO_OF_POKEMONS}" 
              }

  validates :name,
              presence: true,
              length: {
                minimum: 3,
                maximum: 100
              },
              allow_blank: false


  def self.get_by_nationalno nationalno
    pokemon = find_by_nationalno nationalno
    return pokemon unless pokemon.nil?

    puts "Pokemon not found in db for #{nationalno}"
    name = name_from nationalno
    Pokemon.create! nationalno: nationalno, name: name
  end

  def self.random_nationalno *excluded_numbers
    loop do
      num = rand 1..MAX_NO_OF_POKEMONS
      break num unless excluded_numbers[0..20].include? num
    end
  end

  def self.random_pokemon *excluded_nationalnos
    get_by_nationalno random_nationalno(*excluded_nationalnos)
  end

  def self.nationalnos_in_db
    Pokemon.pluck :nationalno
  end

  def self.imagefilepath nationalno
    Rails.root.join("public", "#{nationalno}.jpg")
  end



  def imagefilepath
    raise "Invalid" if not valid?
    filepath = Pokemon.imagefilepath nationalno
    #puts "filepath #{filepath}"

    return filepath if File.file? filepath
    raise "shouldn't be a directory" if File.exists? filepath

    File.open(filepath, 'wb') do |f|
      IO.copy_stream open(image_uri), f #downloading file
    end

    raise unless File.exists? filepath
    filepath
  end

  class << self
    protected
    def poke_endpoint nationalno
      #daily rate limit of 300 requests per resource per IP address..
      "http://pokeapi.co/api/v2/pokemon/#{nationalno}/"
    end

    def name_from nationalno
      puts "Getting pokemon name for #{nationalno} via pokeapi.co"
      url = poke_endpoint nationalno
      response = Net::HTTP.get URI(url)
      json = JSON.parse response
      json['name']
    end

  end

  private
  def image_uri
    padded_no = sprintf '%03d', nationalno
    "http://assets.pokemon.com/assets/cms2/img/pokedex/detail/#{padded_no}.png"
  end

end
