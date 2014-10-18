source 'https://rubygems.org'
ruby "2.1.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development



#customize gem
gem 'jquery-turbolinks'
gem 'bootstrap-sass', '~> 3.2.0.0'
gem 'devise', '~> 3.4.0'

gem 'carrierwave'
gem 'fog'
gem 'mini_magick', '~> 3.8.1'
gem "settingslogic"

gem 'omniauth-facebook'
gem 'open_uri_redirections'
#gem "devise-i18n"
# add for chinese message with devise
gem 'i18n', github: 'svenfuchs/i18n'
#Pry is a ddebug tool


gem 'simple_form', '~> 3.0.2'
#gem 'jquery-turbolinks'



gem 'ransack', github: 'activerecord-hackery/ransack', branch: 'rails-4.1'


#add for seo
gem 'seo_helper', '~> 1.0', :git => 'git://github.com/techbang/seo_helper.git'
gem 'sitemap_generator'

#fb open graph
gem 'open_graph_helper', :github => 'techbang/open_graph_helper'


gem 'rack-cache', '~> 1.2'

#Grape is a REST-like API micro-framework
gem 'grape'
gem 'kramdown'
gem 'grape-swagger'
gem 'grape-rabl'
#disable the security feature of strong parameters for grape
gem "hashie_rails"
#gem 'rack-cors', '~> 0.2.9'

#add pagination for grape api
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'api-pagination'

#for detect the length og audio
#gem 'streamio-ffmpeg'
#gem 'taglib-ruby', '~> 0.7.0'
#gem 'ruby-mp3info', '~> 0.8.5'
gem 'ruby-audioinfo'



group :development, :test do
  #gem 'pry', '~> 0.10.0'
  #gem 'guard-livereload'
  #gem 'annotate', '~> 2.6.5'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'meta_request'
  gem 'better_errors'
  gem "binding_of_caller"
  gem 'guard-livereload'
  gem 'annotate', '~> 2.6.5'
  gem 'awesome_print', :require => false
  gem 'hirb', :require => false
  gem 'hirb-unicode', :require => false
end




#should be delete
#add for heroku
group :production do

  gem 'rails_12factor'
  #add for gzip on heroku
  gem 'heroku-deflater'
end




# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

