class AddNationalNoToPokemon < ActiveRecord::Migration
  def change
    add_index :pokemons, :nationalno, unique: true
  end
end
