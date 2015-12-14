require 'rails_helper'

RSpec.describe TweetComposer do
  client = TwitterClient.new
  results = client.search_tweets_with_images_by_keyword('dream')
  let(:tweet) { results.first }
  let(:filter) { %w(art_deco charcoal facelift watercolor_manet_portrait watercolor_casset_portrait the_scream clashing_by_clayton_kashuba starry_night_portrait van_gogh_portrait kandinsky calligraphy matisse_cliffs durer_melencolia bw_pastel graffiti_2 iridescent mirage springtime tropical_sunrise picasso impasto starry_night_landscape money cafe_terrace cubism nighthawk Inkblot color_pastel jfk_portrait greek_pottery charcoal_sketch two_girls the_wave woman_weeping blue library_of_alexandria northern_renaissance graffiti light_painting stained_glass stained_glass_2 motherboard motherboard_2 oscilloscope codex_davinci matisse_boat matisse_farms street_zebra halloween_web halloween_spider pumpkin halloween_skull graveyard_mist haunted_charcoal halloween_clinton halloween_trump halloween_frankenstein autumn cemetary fire midnight_smoke petrified_wood halloween_pirate bonfire cold_glow english_breakfast inceptionist_painting trippy supertrippy jeweled_bird engraved_clay crayon energy_buzz salvia botanical_dimensions oil_on_canvas self_transforming_machine_elves median sketchasketch sandstorm snow_crash glitch_life angel_hair fanime).sample }

  let(:status) { TweetComposer.compose_dream_tweet(tweet, filter) }

  describe "#compose_dream_tweet" do
    it "status should include 'RT'" do
      status.should include('RT')
    end

    it "status should include #deepdreaming" do
      status.should include('#deepdreaming')
    end

    it "status should include name of the filter used" do
      status.should include("##{filter}")
    end

    it "status should include original tweet user's screen_name" do
      status.should include("@#{tweet.user.attrs[:screen_name]}")
    end
  end
end
