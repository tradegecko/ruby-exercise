class AddGifRefToTweets < ActiveRecord::Migration
  def change
    add_reference :tweets, :gif, index: true
  end
end
