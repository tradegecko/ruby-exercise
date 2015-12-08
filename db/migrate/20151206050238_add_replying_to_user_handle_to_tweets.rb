class AddReplyingToUserHandleToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :replying_to_user_handle, :string
  end
end
