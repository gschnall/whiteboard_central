CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV["AWS_ACCESS_KEY"],
      :aws_secret_access_key  => ENV["AWS_SECRET_KEY"],
      :region                 => 'us-west-1' # Change this for different AWS region. Default is 'us-east-1'
  }
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/public/uploads/boards"

  config.fog_directory  = ENV["AWS_BUCKET"]
end


