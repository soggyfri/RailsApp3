if Rails.env == "production"
  #set credentails in heroku env - user heroku config:add S3_KEY=XYX S3_SECRET=ZZZ
  S3_CREDENTIALS = { :access_key_id => ENV['S3_KEY'],
                     :secret_access_key => ENV['S3_SECRET'],
                     :bucket => "uconn-social-prod" }
else
  S3_CREDENTIALS = Rails.root.join("config/s3.yml")
end