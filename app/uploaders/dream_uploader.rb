# encoding: utf-8

class DreamUploader < CarrierWave::Uploader::Base
  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Create dream versions of uploaded file
  version :dream do
    process :get_dream_image
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end

  private

  def get_dream_image
    # TODO: process in background
    image_to_post = File.new(self.current_path)
    dream_image = DreamScopeApi.get_dream_image image_to_post
    File.open(self.current_path, 'wb') { |file| file.write(dream_image) }
    true
  end
end
