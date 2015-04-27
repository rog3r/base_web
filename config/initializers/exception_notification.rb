#Rails.application.config.middleware.use ExceptionNotifier,
if Rails.env.production?
  require 'exception_notifier'
  Rails.application.config.middleware.use ExceptionNotification::Rack,
                                          :email => {
                                              email_prefix: '[Erro no SISTEMA] ',
                                              sender_address: %{"Portal" <sistemas@cepedi.org.br>},
                                              exception_recipients: %w{rogerio@cepedi.org.br joao@cepedi.org.br}
                                          }
end


