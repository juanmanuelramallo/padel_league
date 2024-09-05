Rails.application.config.action_mailer.delivery_method = :smtp
Rails.application.config.action_mailer.smtp_settings = {
  address: Rails.application.credentials.dig(:smtp, :address),
  domain: Rails.application.credentials.dig(:smtp, :domain),
  user_name: Rails.application.credentials.dig(:smtp, :user_name),
  password: Rails.application.credentials.dig(:smtp, :password),
  authentication: Rails.application.credentials.dig(:smtp, :authentication)
}
Rails.application.config.action_mailer.default_options = {
  from: Rails.application.credentials.dig(:smtp, :from)
}
