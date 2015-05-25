# -------------- Configuração de envio de Email ------------------------------------------
ActionMailer::Base.default_url_options = { host: Rails.application.secrets.host }
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = false
ActionMailer::Base.default charset: 'utf-8'

ActionMailer::Base.smtp_settings = {
    address:              Rails.application.secrets.email['address'] ,
    port:                 Rails.application.secrets.email['port'],
    domain:               Rails.application.secrets.email['domain'],
    authentication:       Rails.application.secrets.email['domain'],
    enable_starttls_auto: Rails.application.secrets.email['domain'],
    user_name:            Rails.application.secrets.email['user'],  # ENV['GMAIL_USERNAME'],
    password:             Rails.application.secrets.email['pass']   # ENV['GMAIL_PASSWORD']
}