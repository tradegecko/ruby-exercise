require 'faker'
require 'byebug'
FactoryGirl.define do
  factory :pokemon do |f|
    f.nationalno { Pokemon.random_nationalno }
    f.name { Faker::Name.name }
  end
end