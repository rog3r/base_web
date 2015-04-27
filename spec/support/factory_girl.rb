RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do #verifica se existe aguma Factory invalida antes de iniciar os testes
    FactoryGirl.lint
  end
end