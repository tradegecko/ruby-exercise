class MoodAnalyser

  # This method responds your mood from the given texts
  def self.analyse_the_mood(array_of_texts)
    return 0 if array_of_texts.length == 0
    analyzer = Sentimental.new
    analyzer.threshold = 0.1
    analyzer.load_defaults # the defaults dicts are really lame, this should be replace by a self generated dict

    score = 0
    array_of_texts.each do |text|
      score += analyzer.score text.to_s
    end

    result =  score.to_f / array_of_texts.length
    if result > 0.2
      return :positive
    elsif result < -0.2
      return :negative
    end
    :neutral
  end
end
