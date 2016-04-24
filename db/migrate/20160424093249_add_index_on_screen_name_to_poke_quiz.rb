class AddIndexOnScreenNameToPokeQuiz < ActiveRecord::Migration
  def change
    add_index :poke_quizzes, :screenname, unique: true
  end
end
