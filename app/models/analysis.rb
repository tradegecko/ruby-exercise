class Analysis < ActiveRecord::Base
  belongs_to :movie
  has_many :analysis_tweets
  has_many :tweets, through: :analysis_tweets

  def populate_analysis
    %w(positive neutral negative).map { |method| send("#{method}=", 0) }
    tweets.group_by{ |tweet| tweet.sentiment }
          .map { |type, group| send("#{type}=", group.count) }
    save
  end
end
