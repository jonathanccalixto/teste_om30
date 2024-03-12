# frozen_string_literal: true

Rails.application.config.action_mailer.delivery_method = :smtp

if Rails.env.development?
  # Don't care if the mailer can't send.
  mail_domain = ENV.fetch('DOMAIN', "localhost:#{ENV.fetch('PORT', 3000)}")

  Rails.application.config.action_mailer.asset_host = "http://#{mail_domain}"
  Rails.application.config.action_mailer.perform_deliveries = true
  Rails.application.config.action_mailer.default_url_options = { host: mail_domain }
  Rails.application.config.action_mailer.raise_delivery_errors = true
  Rails.application.config.action_mailer.perform_caching = false
  Rails.application.config.action_mailer.smtp_settings = {
    address: ENV.fetch('MAILCATCHER_HOST', 'localhost'),
    port: ENV.fetch('MAILCATCHER_PORT', 1025)
  }
elsif Rails.env.production?
  # Don't care if the mailer can't send.
  mail_domain = ENV.fetch('DOMAIN', 'om30.herokuapp.com')

  Rails.application.config.action_mailer.asset_host = "https://#{mail_domain}"
  Rails.application.config.action_mailer.default_url_options = { host: mail_domain }
  Rails.application.config.action_mailer.perform_caching = false
  Rails.application.config.action_mailer.smtp_settings = {
    user_name: ENV.fetch('SENDGRID_USERNAME', nil),
    password: ENV.fetch('SENDGRID_PASSWORD', nil),
    address: ENV.fetch('SENDGRID_HOST', 'smtp.sendgrid.net'),
    port: ENV.fetch('SENDGRID_PORT', 587),
    authentication: :plain,
    enable_starttls_auto: true
  }
end
