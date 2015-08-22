Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # set for devise
  # config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  #add for adding view helper in rabl view
  routes.default_url_options = { host: "127.0.0.1.xip.io", port: 3000 }

  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { host: '127.0.0.1.xip.io', port: 3000 }
  config.action_mailer.asset_host = '127.0.0.1.xip.io:3000'
  config.action_controller.asset_host = '127.0.0.1.xip.io:3000'

  #Shoule be delete
  #Add for Heroku, It should be deleted after migrate to AWS
  CarrierWave.configure do |config|
    config.storage :file
  end
  ###########################################


  # Add for sending email
  config.action_mailer.default_url_options = { host: 'https://bab.bo' }

  ActionMailer::Base.smtp_settings = {
    :port           => Settings.MAILGUN_SMTP_PORT, #E NV['MAILGUN_SMTP_PORT'],
    :address        => Settings.MAILGUN_SMTP_SERVER, # ENV['MAILGUN_SMTP_SERVER'],
    :user_name      => Settings.MAILGUN_SMTP_LOGIN, # ENV['MAILGUN_SMTP_LOGIN'],
    :password       => Settings.MAILGUN_SMTP_PASSWORD, # ENV['MAILGUN_SMTP_PASSWORD'],
    :domain         => 'bab.bo', # 'goodtime.com.tw',
    :authentication => :plain,
  }
  ActionMailer::Base.delivery_method = :smtp

  config.action_mailer.asset_host = 'http://bab.bo' # 'http://goodtime.com.tw'
end
