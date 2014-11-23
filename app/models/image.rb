require 'chunky_png'
require 'colorscore'

# Image and color processor for the bot
class Image

  # Location to store temporary images created
  PATH = 'public/temp/'
  IMG_WIDTH = 200

  # Return file containing image of the given hex color
  def self.get_image_for_hex(hex)
    # Creating an image from scratch, save as an interlaced PNG
    png = ChunkyPNG::Image.new(IMG_WIDTH, IMG_WIDTH, ChunkyPNG::Color.from_hex(hex))
    # Name png with hex value
    file_name = PATH + hex.to_s + '.png'
    png.save(file_name, :interlace => true)

    # Init image file
    file = File.new(file_name)

    return file
  end

  # Returns the predominant hex value for the given image
  def self.get_hex_value(url)
    # Creates a histogram of colors for an image
    histogram = Colorscore::Histogram.new(url.to_s)
    # Exract the dominant color from the histogram
    hex_value = histogram.scores.first.last.hex

    return '#' + hex_value
  end

  # Clears the /public/temp folder of all images created
  def self.clear_saved_images
    FileUtils.rm_rf(Dir.glob(PATH + '*'))
  end

end