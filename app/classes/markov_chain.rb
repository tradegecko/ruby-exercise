class MarkovChain
  def initialize(text:"", word_hash: Hash.new)
    @words = word_hash
    wordlist = text.split
    wordlist.each_with_index do |word, index|
      add(word, wordlist[index + 1]) if index <= wordlist.size - 2
    end
  end

  def add(word, next_word)
    @words[word] = Hash.new(0) if !@words[word]
    @words[word][next_word] += 1
  end

  def get(word)
    return random_word if !@words[word]
    followers = @words[word]
    sum = followers.inject(0) {|sum,kv| sum += kv[1]}
    random = rand(sum)+1
    partial_sum = 0
    next_word = followers.find do |word, count|
      partial_sum += count
      partial_sum >= random
    end.first
  end

  def word_hash
    @words
  end
  # Convenience methods to easily access words and sentences

  def random_word 
    @words.keys.sample
  end

  def words(count = 1, start_word = nil)
    sentence  = []
    word      = start_word || random_word
    last_word = 
    count.times do
      sentence << word
      word = get(word)
    end
    sentence.map(&:strip).join(" ").split('.')[0]
  end

  def sentences(count = 1, start_word = nil)
    word      = start_word || random_word
    sentences = ''
    until sentences.count('.') == count
      sentences << words(rand(20) + 5, word).capitalize << '. '
      word = get(word)
    end
    sentences.split(" ").join(" ")
  end
end
