require 'rails_helper'

describe Sentwix do

  subject { Sentwix }
  let(:topic) { 'Penguins Of Madagascar' }

  describe '.analyze_movie' do
    it 'analyze topics when movie ' do
      expect(Sentwix.analyze_movie(topic)).to be_a Array
    end

    it 'raise error when movie title is nil' do
      expect{ Sentwix.analyze_movie(nil) }.to raise_error Sentwix::InvalidMovieError
    end

    it 'raise error when movie title is empty string' do
      expect{ Sentwix.analyze_movie("") }.to raise_error Sentwix::InvalidMovieError
    end
  end

end
