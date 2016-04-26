class CreatePokeQuizzes < ActiveRecord::Migration
  def change
    create_table :poke_quizzes do |t|
      t.string :screenname
      t.integer :statusid, limit: 8
      t.integer :lastpokemonno
      t.boolean :returninggamer
      t.integer :status
      t.integer :totalans
      t.integer :wrongans
      t.string :addinfo

      t.timestamps
    end
  end
end
