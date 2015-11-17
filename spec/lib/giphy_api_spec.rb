require 'rails_helper'

RSpec.describe GiphyApi do

  describe '#fetch_random_gif' do
    subject { GiphyApi.new.fetch_random_gif(keyword) }

    context 'with no keyword' do
      let(:keyword) { nil }
      it 'should return a random gif url' do
        VCR.use_cassette('giphy/random_gif_without_a_search_keyword') do
          url = subject
          expect(url).to be_a URI
          expect(url.to_s).to include '.gif'
        end
      end
    end

    context 'with non empty keyword' do
      context 'result found on the keyword' do
        let(:keyword) { 'Hola' }
        it 'should return a random gif url' do
          VCR.use_cassette('giphy/random_search_with_a_gif_result') do
            url = subject
            expect(url).to be_a URI
            expect(url.to_s).to include '.gif'
          end
        end
      end

      context 'result found on the keyword' do
        let(:keyword) { 'ThereShouldBeNoWayThatThereIsAGifUnderThisName' }
        it 'should return nil' do
          VCR.use_cassette('giphy/random_search_with_empty_result') do
            expect(subject).to be_nil
          end
        end
      end
    end
  end
end