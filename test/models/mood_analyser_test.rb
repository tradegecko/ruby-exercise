require 'test_helper'

class MoodAnalyserTest < ActiveSupport::TestCase
  context 'check the mood analyser is up and running' do
    should 'return positive when given positive texts' do
      assert_equal :positive, MoodAnalyser.analyse_the_mood(%w(happy good like))
    end

    should 'return negative when given negative texts' do
      assert_equal :negative, MoodAnalyser.analyse_the_mood(%w(sad bad hate))
    end

    should 'return neutral when given neutral texts' do
      assert_equal :neutral, MoodAnalyser.analyse_the_mood(%w(neutral rails ruby))
    end
  end
end
