require 'rails_helper'

RSpec.describe Dreamer do
  subject(:dreamer) { Dreamer.send(:new, 'dream') }
  describe '#dream_image' do
    subject { dreamer.send(:dream_image) }
    it { is_expected.to be_a DreamImage }
    its(:twitter_id) { is_expected.to be }
    its(:image_url) { is_expected.to be }

    context "no new images" do
      before do
        allow(DreamImage).to receive(:exists?) { true }
      end
      it 'raises error' do
        expect{ subject }.to raise_error
      end
    end
  end


end
