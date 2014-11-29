require 'rails_helper'

describe Sentwix::Filter do
  
  subject { Sentwix::Filter }

  describe '.filter_movie_text' do
    it 'filters the movie title from the tweet text' do
      movie_title = "Horrible Bosses 2"
      tweet_text = "Horrible Bosses 2 is a great movie!"
      filtered_text = subject.filter_movie_text(tweet_text, movie_title)
      expect(filtered_text).not_to include movie_title
    end
  end
end
