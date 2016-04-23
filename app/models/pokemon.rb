require 'pokeutils'
class Pokemon < ActiveRecord::Base
  include PokeUtilities
  
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


  def self.random_nationalno *excluded_numbers
    loop do
      num = rand 1..MAX_NO_OF_POKEMONS
      break num unless excluded_numbers[0..20].include? num
    end
  end

  def self.random_pokemon *excluded_nationalnos
    self.get_by_nationalno self.random_nationalno(*excluded_nationalnos)
  end

  def self.get_by_nationalno nationalno
    pokemon = Pokemon.find_by_nationalno nationalno
    return pokemon unless pokemon.nil?

    puts "Pokemon not found in db for #{nationalno}"
    name = PokeUtilities.name_from nationalno
    Pokemon.create! nationalno: nationalno, name: name
  end

  def self.cached_nationalnos
    Pokemon.pluck :nationalno
  end

end
