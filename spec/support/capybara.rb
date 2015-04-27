Capybara.asset_host = 'http://localhost:3000'


require 'selenium-webdriver'
Capybara.default_driver = :selenium #set the default driver
Capybara.default_wait_time = 5

Capybara.register_driver :selenium do |app|
  #Capybara Chrome fullscreen
  caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => { args: [ '--start-maximized' ]})
  Capybara::Selenium::Driver.new(app, {browser: :chrome, desired_capabilities: caps})
end






####
#
# pass environment variables to control which browser is used for testing. Default is HEADLESS/POLTERGEIST
# usage: firefox=true bundle exec cucumber features/test.feature
#
####

#if ENV['chrome']
#  Capybara.default_driver = :chrome
#  Capybara.register_driver :chrome do |app|
#    options = {
#        js_errors: false,
#        timeout: 360,
#        debug: false,
#        inspector: false,
#    }
#    Capybara::Selenium::Driver.new(app, browser: :chrome)
#  end
#elsif ENV['firefox']
#  Capybara.default_driver = :firefox
#  Capybara.register_driver :firefox do |app|
#    options = {
#        js_errors: true,
#        timeout: 360,
#        debug: false,
#        inspector: false,
#    }
#    Capybara::Selenium::Driver.new(app, browser: :firefox)
#  end
#elsif ENV['safari']
#  Capybara.default_driver = :safari
#  Capybara.register_driver :safari do |app|
#    options = {
#        js_errors: false,
#        timeout: 360,
#        debug: false,
#        inspector: false,
#    }
#    Capybara::Selenium::Driver.new(app, browser: :safari)
#  end
#elsif ENV['opera']
#  Capybara.default_driver = :opera
#  Capybara.register_driver :opera do |app|
#    options = {
#        js_errors: false,
#        timeout: 360,
#        debug: false,
#        inspector: false,
#    }
#    Capybara::Selenium::Driver.new(app, browser: :opera)
#  end
#elsif Capybara.default_driver = :poltergeist
#  Capybara.register_driver :poltergeist do |app|# Register slightly larger than default window size...
#    options = {
#        js_errors: false,
#        timeout: 360,
#        debug: false,
#        phantomjs_options: ['--load-images=no', '--disk-cache=false'],
#        inspector: false,
#    }
#    Capybara::Poltergeist::Driver.new(app)
#   # Capybara::Poltergeist::Driver.new(app, { debug: false, # change this to true to troubleshoot
#                                            # window_size: [1300, 1000] # this can affect dynamic layout
#                                            # })
#
#  end
#end
#
#
#
#
#################################################################################





#To ask capybara to use chrome, add this here or into test_helper.rb:
#Capybara.register_driver :chrome do |app|
#  Capybara::Selenium::Driver.new(app, browser: :chrome)
#end
#
#Capybara.javascript_driver = :chrome # http://chromedriver.storage.googleapis.com/index.html


#require 'capybara/poltergeist'
#
#Capybara.register_driver :poltergeist do |app|
#  Capybara::Poltergeist::Driver.new(app, {debug: false})
#end
#
#Capybara.default_driver    = :poltergeist  #set the default driver
#Capybara.javascript_driver = :poltergeist

