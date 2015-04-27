require 'support/helpers/devise_session_helpers'
RSpec.configure do |config|
  config.include Features::DeviseSessionHelpers, type: :feature
end