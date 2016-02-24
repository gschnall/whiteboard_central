class Board < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable
  #mount_uploader :title, ImageUploader
end
