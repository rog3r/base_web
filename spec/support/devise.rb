#include Warden::Test::Helpers
#Warden.test_mode!
require 'devise'
RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
end