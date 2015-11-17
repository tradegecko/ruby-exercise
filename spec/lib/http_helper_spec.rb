require 'rails_helper'

RSpec.describe HttpHelper do

  describe '#download_file' do
    subject { HttpHelper.download_file(url) }

    context 'correct url' do
      let(:url) { URI('http://giphy.com/gifs/melissa-benoist-helpers-11VoHjrmqUCye4') }

      it 'returns the downloaded file' do
        VCR.use_cassette('http/download_a_file') do
          expect(subject).to be_a File
        end
      end
    end

    context 'incorrect url' do
      let(:url) { URI('http://this_url_does_not_exists.com/gifs/something_random') }

      it 'raise an error' do
          expect{subject}.to raise_error URI::InvalidURIError
      end
    end
  end
end