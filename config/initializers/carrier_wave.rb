if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => ENV['AKIAJ4YARQXFSIZDXKOQ'],
    :aws_secret_access_key => ENV['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']
    }
    config.fog_directory = ENV['windaqimages1']
  end
end