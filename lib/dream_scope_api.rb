require 'rest-client'
# Communicate with https://dreamscopeapp.com frontend
#   by uploading an image then downloading the result
class DreamScopeApi
  BASE_URL = 'https://dreamscopeapp.com/api/images'.freeze

  def self.get_dream_image(original_image)
    new()
      .upload(original_image)
      .result
  end

  def upload(image)
    response = JSON.parse RestClient.post(BASE_URL, post_data(image))
    RemoteImage.new(response['uuid'])
  end

  private

  def post_data(image)
    {
      filter: STYLES.sample,
      image: image
    }
  end

  STYLES = %i(
    angel_hair
    botanical_dimensions
    cafe_terrace
    calligraphy
    clashing_by_clayton_kashuba
    greek_pottery
    halloween_clinton
    halloween_pirate
    inceptionist_painting
    jeweled_bird
    kandinsky
    library_of_alexandria
    money
    motherboard
    motherboard_2
    picasso
    stained_glass
    stained_glass_2
    starry_night_landscape
    starry_night_portrait
    street_zebra
    supertrippy
  ).freeze
end
