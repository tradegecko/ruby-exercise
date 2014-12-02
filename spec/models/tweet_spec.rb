require 'rails_helper'

describe Tweet do
  describe 'associations' do
    it { should belong_to :movie }
  end

  describe 'validations' do
    it { should validate_presence_of :object }
  end
end
