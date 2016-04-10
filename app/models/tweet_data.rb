class TweetData < ActiveRecord::Base
  def self.word_hash
    hash = {}
    all.each do |datum| 
      chain = MarkovChain.new(text: datum.content, word_hash: hash)
      hash = chain.word_hash
    end
    hash
  end

  def self.chain
    MarkovChain.new(word_hash: self.word_hash)
  end

  def self.generate
    sentences = self.chain.sentences(10).truncate(130).split('.')
    sentences.pop
    sentences.join('.') << '.'
  end

  def self.generate_tweet
    content = "#{self.generate} #kpop #bot"
    Tweet.create content: content
  end
end
