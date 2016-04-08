require 'rails_helper'

RSpec.describe Tweet, type: :model do
  subject(:tweet) { build :tweet }

  it { is_expected.to be_valid }
  its(:aasm_state) { is_expected.to eql "new" }

  describe 'Validations' do
    context 'when content is empty' do
      before do
        subject.content = ''
      end

      it { is_expected.not_to be_valid }
    end
  end
end
