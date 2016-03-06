class ImageUploader < CarrierWave::Uploader::Base
 
  include CarrierWave::MiniMagick
 
  storage :file
 
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
 
  version :thumb, :from_version => :medium do
    process resize_to_fit: [100, 100]
  end
 
  version :square do
    process :resize_to_fill => [500, 500]
  end
 
end
