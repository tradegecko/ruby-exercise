require 'rails_helper'
require 'faker'

RSpec.describe Pokemon, type: :model do

  it "has a valid FactoryGirl" do
    expect(FactoryGirl.build(:pokemon)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:pokemon, name: nil)).not_to be_valid
  end

  it "is invalid without a nationalno" do
    expect(FactoryGirl.build(:pokemon, nationalno: nil)).not_to be_valid
  end

  it "should be between 0 and #{Pokemon::MAX_NO_OF_POKEMONS}" do
    expect(FactoryGirl.build(:pokemon, nationalno: 0)).not_to be_valid
    expect(FactoryGirl.build(:pokemon, nationalno: -1)).not_to be_valid
    expect(FactoryGirl.build(:pokemon, nationalno: Pokemon::MAX_NO_OF_POKEMONS + 1)).not_to be_valid
  end

  it "should not have duplicates" do
    expect(FactoryGirl.create(:pokemon, nationalno: 1)).to be_valid
    expect(FactoryGirl.build(:pokemon, nationalno: 1)).not_to be_valid
  end


  describe ".random_nationalno" do

    it "should generate between 0 and #{Pokemon::MAX_NO_OF_POKEMONS}" do
      expect(Pokemon.random_nationalno).to be >= 1
      expect(Pokemon.random_nationalno).to be <= Pokemon::MAX_NO_OF_POKEMONS
    end

    it "should not include excludednums" do
      excludednums = (5..10).to_a

      expect(Pokemon.random_nationalno(excludednums)).not_to satisfy { |num| excludednums.include? num }
    end

  end


  describe ".get_by_nationalno" do
    #require 'byebug'; byebug
    it "should get and create a pokemon not in db" do
      exclude_nationalnos = Pokemon.cached_nationalnos
      count = Pokemon.count
      pokemon = Pokemon.random_pokemon exclude_nationalnos

      expect(pokemon).to be_valid
      expect(Pokemon.count).to eq(count + 1)

      Pokemon.get_by_nationalno pokemon.nationalno
      expect(Pokemon.count).to eq(count + 1)
    end

  end

end
