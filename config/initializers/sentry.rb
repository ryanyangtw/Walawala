if Rails.env.production? || Rails.env.staging?
  Raven.configure do |config|
    config.dsn = Settings.SENTRY_DSN # ENV['SENTRY_DSN']
    config.environments = %w[ production ]
  end
end