require 'database_cleaner'

RSpec.configure do |config|

  config.before(:suite) do
   # FactoryGirl.lint  #verifica se existe aguma Factory invalida antes de iniciar os testes
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end