class AddMovieIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :movie_id, :integer
  end
end
