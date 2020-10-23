if Rails.env.production? || Rails.env.staging?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:              'AWS',
      region:                Rails.application.credentials.aws[:S3_REGION],
      aws_access_key_id:     Rails.application.credentials.aws[:S3_ACCESS_KEY],
      aws_secret_access_key: Rails.application.credentials.aws[:S3_SECRET_KEY]
    }

    config.fog_directory  = Rails.application.credentials.aws[:S3_BUCKET_NAME]
  end
end
