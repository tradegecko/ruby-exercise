class DreamImage < ActiveRecord::Base
  validates_presence_of :twitter_id, :image
  mount_uploader :image, DreamUploader
end
