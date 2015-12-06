class DreamscopeappClient
  BASE_URL = "https://dreamscopeapp.com/api/images".freeze

  attr_reader :filter

  def initialize file_path
    @filter = FILTERS.sample
    form = { form: { filter: @filter, image: HTTP::FormData::File.new(file_path) } }
    response_hash = JSON.parse(HTTP.post(BASE_URL, form).to_s)
    @pulling_url = BASE_URL +  '/' + response_hash['uuid']
  end

  def pull
    loop do
      @pulling_response = JSON.parse(HTTP.get(@pulling_url).to_s)
      return @pulling_response['filtered_url'] if processing_complete?
      sleep 30
    end
  end

  private

  def processing_complete?
    @pulling_response['processing_status'].nonzero?
  end

  FILTERS = %w(art_deco charcoal facelift watercolor_manet_portrait watercolor_casset_portrait the_scream clashing_by_clayton_kashuba starry_night_portrait van_gogh_portrait kandinsky calligraphy matisse_cliffs durer_melencolia bw_pastel graffiti_2 iridescent mirage springtime tropical_sunrise picasso impasto starry_night_landscape money cafe_terrace cubism nighthawk Inkblot color_pastel jfk_portrait greek_pottery charcoal_sketch two_girls the_wave woman_weeping blue library_of_alexandria northern_renaissance graffiti light_painting stained_glass stained_glass_2 motherboard motherboard_2 oscilloscope codex_davinci matisse_boat matisse_farms street_zebra halloween_web halloween_spider pumpkin halloween_skull graveyard_mist haunted_charcoal halloween_clinton halloween_trump halloween_frankenstein autumn cemetary fire midnight_smoke petrified_wood halloween_pirate bonfire cold_glow english_breakfast inceptionist_painting trippy supertrippy jeweled_bird engraved_clay crayon energy_buzz salvia botanical_dimensions oil_on_canvas self_transforming_machine_elves median sketchasketch sandstorm snow_crash glitch_life angel_hair fanime).freeze

end
