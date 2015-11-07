require 'rails_helper'

RSpec.describe Dreamer do
  subject(:dreamer) { Dreamer.new }
  describe '#image_to_dream' do
    subject { dreamer.send(:image_to_dream, 'dream') }
    it { is_expected.to be_a DreamImage }
    its(:twitter_id) { is_expected.to be }
    its(:image_url) { is_expected.to be }

    context "no new images" do
      before do
        allow(DreamImage).to receive(:exists?) { true }
      end
      it { is_expected.to be_nil }
    end
  end


end
