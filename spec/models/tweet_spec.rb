require 'rails_helper'

describe Tweet do
  it { should validate_presence_of :text }
  it { should validate_presence_of :created_at }
end
