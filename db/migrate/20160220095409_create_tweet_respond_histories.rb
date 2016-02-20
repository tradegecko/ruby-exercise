class CreateTweetRespondHistories < ActiveRecord::Migration
  def change
    create_table :tweet_respond_histories do |t|
      t.string :respond_status_id
      t.string :tweet_text

      t.timestamps
    end
  end
end
