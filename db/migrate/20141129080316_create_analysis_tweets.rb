class CreateAnalysisTweets < ActiveRecord::Migration
  def change
    create_table :analysis_tweets do |t|
      t.integer :analysis_id
      t.integer :tweet_id
      t.timestamps
    end
  end
end
