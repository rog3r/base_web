#Rails.application.config.middleware.use ExceptionNotifier,
if Rails.env.production?
  require 'exception_notifier'
  Rails.application.config.middleware.use ExceptionNotification::Rack,
                                          email: {
                                              email_prefix: '[Erro no SISTEMA] ',
                                              sender_address: %{"Portal" <sistemas@baseweb.com.br>},
                                              exception_recipients: %w{rogerio@cepedi.org.br joao@cepedi.org.br}
                                          }



  # -------------- Configuração de envio de Email ------------------------------------------
  #Whatever::Application.config.middleware.use ExceptionNotification::Rack,
  #config.middleware.use ExceptionNotification::Rack,
  #                                            :email => {
  #                                                :email_prefix => "[Exception] ",
  #                                                :sender_address => %{"notifier" <sistemas@baseweb.com.br>},
  #                                                :exception_recipients => %w{rogerio@baseweb.com.br}
  #                                            }
end


