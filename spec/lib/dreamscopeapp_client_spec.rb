require 'rails_helper'

RSpec.describe DreamscopeappClient do
  
  
  filters = %w(art_deco charcoal facelift watercolor_manet_portrait watercolor_casset_portrait the_scream clashing_by_clayton_kashuba starry_night_portrait van_gogh_portrait kandinsky calligraphy matisse_cliffs durer_melencolia bw_pastel graffiti_2 iridescent mirage springtime tropical_sunrise picasso impasto starry_night_landscape money cafe_terrace cubism nighthawk Inkblot color_pastel jfk_portrait greek_pottery charcoal_sketch two_girls the_wave woman_weeping blue library_of_alexandria northern_renaissance graffiti light_painting stained_glass stained_glass_2 motherboard motherboard_2 oscilloscope codex_davinci matisse_boat matisse_farms street_zebra halloween_web halloween_spider pumpkin halloween_skull graveyard_mist haunted_charcoal halloween_clinton halloween_trump halloween_frankenstein autumn cemetary fire midnight_smoke petrified_wood halloween_pirate bonfire cold_glow english_breakfast inceptionist_painting trippy supertrippy jeweled_bird engraved_clay crayon energy_buzz salvia botanical_dimensions oil_on_canvas self_transforming_machine_elves median sketchasketch sandstorm snow_crash glitch_life angel_hair fanime)

  rspec_file_path = File.join Rails.root, 'public', 'rspec.png'
  let(:client) { DreamscopeappClient.new(rspec_file_path.to_s) }

  describe "#new" do
    it "should return an instance of DreamscopeappClient" do
      client.should be_an_instance_of DreamscopeappClient
    end

    it "client should use one the filter above" do
      filters.should include(client.filter)
    end
  end

  let (:filter_image_url) { client.pull }

  # Take too long to complete, comment out by default
  # describe "#pull" do
  #   it "should be able to pull filtered image from dreamscope server" do
  #     filter_image_url.should include('dreamscope')
  #     filter_image_url.should include('images')
  #   end
  # end
end
