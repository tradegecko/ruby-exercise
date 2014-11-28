require 'rails_helper'

describe Analysis do
  describe 'associations' do
    it { should belong_to :movie }
  end
end
