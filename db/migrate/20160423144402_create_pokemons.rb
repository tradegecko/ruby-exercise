class CreatePokemons < ActiveRecord::Migration
  def change
    create_table :pokemons do |t|
      t.integer :nationalno
      t.string :name

      t.timestamps
    end
  end
end
