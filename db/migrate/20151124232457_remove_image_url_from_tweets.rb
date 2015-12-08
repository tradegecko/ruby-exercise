class RemoveImageUrlFromTweets < ActiveRecord::Migration
  def change
    remove_column :tweets, :image_url, :string
  end
end
