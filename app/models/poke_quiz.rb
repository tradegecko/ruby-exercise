class PokeQuiz < ActiveRecord::Base
  MAX_QUESTIONS = 3

  module Status
    LIVE      = 0
    COMPLETED = 1
  end

  after_initialize :init

  def init
    self.returninggamer ||= false #if it's already false, it'll again set to false only.. so no problems..
    self.status         ||= Status::LIVE
    self.totalans       ||= 0
    self.wrongans       ||= 0
  end

  validates :screenname, 
              presence: true, 
              uniqueness: { 
                case_sensitive: false
              },
              length: {
                minimum: 3,
                maximum: 20
              },
              allow_blank: false

  validates :statusid, presence: true, uniqueness: true
  validates :lastpokemonno, presence: true, inclusion: { in: 1..Pokemon::MAX_NO_OF_POKEMONS } #don't want to define it as foreignkey
  validates :returninggamer, inclusion: { in: [true, false] } #can't use presence: true for booleans
  validates :status, presence: true, inclusion: { in: Status::LIVE..Status::COMPLETED }
  validates :totalans, :wrongans, presence: true, inclusion: { in: 0..MAX_QUESTIONS }

  serialize :addinfo, JSON

  def self.new_game screenname, statusid
    pokequiz = PokeQuiz.new screenname:    screenname,
                            statusid:      statusid,
                            lastpokemonno: Pokemon.random_pokemon.nationalno, #gets from api and creates the row dynamically and returns no. :)
                            addinfo:       Array.new
    pokequiz.addinfo << pokequiz.lastpokemonno unless pokequiz.addinfo.include? pokequiz.lastpokemonno
    pokequiz.create!
  end

  def renew_game! new_statusid
    excluded_pokemon_nos = self.addinfo
    self.statusid = new_statusid
    self.lastpokemonno = Pokemon.random_pokemon(*excluded_pokemon_nos).nationalno
    self.status = Status::LIVE
    self.returninggamer = true
    self.totalans = 0
    self.wrongans = 0
    (self.addinfo ||= Array.new) << self.lastpokemonno
    self.addinfo = self.addinfo.last 20
    self.save!
    self
  end

  def prepare_next_question!
    excluded_pokemon_nos = self.addinfo
    self.lastpokemonno = Pokemon.random_pokemon(*excluded_pokemon_nos).nationalno
    (self.addinfo ||= Array.new) << self.lastpokemonno
    self.addinfo = self.addinfo.last 20
    self.save!
    self
  end

  def pokemon #TODO should change it to associations
    Pokemon.find_by_nationalno self.lastpokemonno
  end

  def end_of_game?
    self.totalans == PokeQuiz::MAX_QUESTIONS
  end



end
