require 'rails_helper'

describe Tweet do
  it { should validate_presence_of :object }
end
