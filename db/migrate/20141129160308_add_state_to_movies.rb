class AddStateToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :state, :integer
  end
end
