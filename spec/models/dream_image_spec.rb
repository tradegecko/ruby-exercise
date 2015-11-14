require 'rails_helper'

RSpec.describe DreamImage, type: :model do
  it { should validate_presence_of :twitter_id }
  it { should validate_presence_of :image }
end
