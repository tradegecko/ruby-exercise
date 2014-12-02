class Analysis < ActiveRecord::Base
  belongs_to :movie
  has_many :analysis_tweets
  has_many :tweets, through: :analysis_tweets
  has_one :outcome

  after_create :create_outcome

  def populate_analysis
    %w(positive neutral negative).map { |method| send("#{method}=", 0) }
    tweets.group_by{ |tweet| tweet.sentiment }
          .map { |type, group| send("#{type}=", group.count) unless type.nil? }
    save
  end

  def sentiment_count
    %w(positive neutral negative).map{ |s| send(s) }.reduce(:+)
  end

  def total_weighted_sum
    Tweet.sentiments.map{|sentiment, value| send(sentiment) * value }.reduce(:+)
  end

  def weighted_average
    (total_weighted_sum.to_f / sentiment_count.to_f).round(2)
  end

  def create_outcome
    Outcome.create(movie_id: movie.id, analysis_id: self.id)
  end
end
