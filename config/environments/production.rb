Rails.application.configure do
  HOST = 'voice-lbu.heroku.com'
  config.action_controller.perform_caching = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = {host: HOST}
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :port           => ENV['MAILGUN_SMTP_PORT'],
    :address        => ENV['MAILGUN_SMTP_SERVER'],
    :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
    :password       => ENV['MAILGUN_SMTP_PASSWORD'],
    :domain         => HOST,
    :authentication => :plain,
  }
  config.active_record.dump_schema_after_migration = false
  config.active_support.deprecation = :notify
  config.assets.compile = false
  config.assets.digest = true
  config.assets.js_compressor = :uglifier
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.eager_load = true
  config.log_formatter = ::Logger::Formatter.new

  # config.log_level = :debug

  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::DEBUG

  config.serve_static_assets = true
  config.i18n.fallbacks = true
end
