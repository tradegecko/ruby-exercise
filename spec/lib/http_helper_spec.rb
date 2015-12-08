require 'rails_helper'
require 'http_helper'

RSpec.describe HttpHelper do

  describe '#download_file' do
    subject { HttpHelper.download_file(url) }

    context 'correct url' do
      let(:url) { URI('http://media3.giphy.com/media/LizJ8r4pDrzmE/giphy.gif') }

      it 'returns the downloaded file' do
        VCR.use_cassette('http/download_a_file') do
          expect(subject).to be_a File
        end
      end
    end

    context 'incorrect url' do
      let(:url) { URI('http://this_url_does_not_exists.com/gifs/something_random') }

      it 'raise an error' do
        expect { subject }.to raise_error URI::InvalidURIError
      end
    end
  end

  describe '#get_json' do
    subject { HttpHelper.get_json(url) }
    let(:url) { URI('https://www.thegamegal.com/wordgenerator/generator.php?game=2&category=8') }

    it 'returns the Json response' do
      VCR.use_cassette('http/get_json') do
        expect(subject).to be_a Hash
        expect(subject['success']).to be_truthy
      end
    end
  end
end