source 'http://rubygems.org'
#ruby '2.1.5'
gem 'rails', '~> 4.2.0'           # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'sass-rails', '~> 5.0'   # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'     # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.1.0' # Use CoffeeScript for .js.coffee assets and views
gem 'coffee-script-source', '1.8.0', platforms: [:x64_mingw,:mingw, :mswin]

gem 'nokogiri'

gem 'jquery-rails'             # Use jquery as the JavaScript library
gem 'turbolinks'               # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jbuilder', '~> 2.0'       # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder

gem 'bootstrap-sass'#, '3.1.1.1'
gem 'bootswatch-rails'


gem 'momentjs-rails'
gem 'datetimepicker-rails', github: 'zpaulovics/datetimepicker-rails', branch: 'master', submodules: true

gem 'jquery-fileupload-rails'

gem 'devise' #autenticacao
gem 'pundit'
gem 'carrierwave' #File Upload
#gem 'mini_magick'
gem 'the_role', '~> 2.5.2'
gem 'the_role_bootstrap3_ui'

gem 'paperclip', '~> 4.2'
gem 'roo'
gem 'remotipart', '~> 1.2'

gem 'paper_trail'  # Controle de versão de Objetos

gem 'ransack'
gem 'thin'

gem 'responders'
gem 'will_paginate' # Pagination
gem 'bootstrap-will_paginate' # Pagination Styles

gem 'nested_form'
gem 'tzinfo-data', platforms: [:x64_mingw, :mingw, :mswin]# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'seed_dump'
gem 'schema_plus' , github: 'SchemaPlus/schema_plus', branch: 'master', submodules: true if RUBY_VERSION > '2.0.0'
gem 'newrelic_rpm'
#gem 'rack-mini-profiler'
gem 'validates_lengths_from_database'

group :development do
  gem 'annotate'
  gem 'better_errors' , platforms: [:x64_mingw, :mingw, :mswin]
  gem 'binding_of_caller'
  gem 'quiet_assets'
end

group :production, :staging do
  gem 'pg'
  gem 'rails_12factor'
  gem 'exception_notification' #, github: 'smartinez87/exception_notification' # Notificacao de erros na aplicacao para o email da aplicacao
  #gem 'unicorn'
  gem 'therubyracer',  platforms: :ruby
end

group :doc do
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'sqlite3'                # Use sqlite3 as the database for Active Record
  gem 'rspec-rails'
  gem 'factory_girl_rails'

  #gem 'letter_opener'
  #gem 'pry-rails', '~> 0.3.2'
  #gem 'byebug', '~> 2.7.0'
  #gem 'jasmine-rails', '~> 0.5.1'
  #gem 'jasmine', '1.3.0'
  #gem 'foreman', '~> 0.63.0'
  #gem 'betterlorem'
end

group :test do
  gem 'shoulda-matchers'
  gem 'faker'
  gem 'database_cleaner'       # Database Cleaner
  gem 'capybara'               # DOM Dominator
  gem 'capybara-screenshot'    # screenshot failed tests
  gem 'selenium-webdriver'
end
