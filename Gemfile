source 'http://rubygems.org'

gem 'rails', '3.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'



# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'


# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'
group :assets do
  gem 'sass-rails', "~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end
gem 'jquery-rails'

gem 'json'
gem 'geocoder'
gem 'haml'
gem 'indextank'
gem 'tanker' #, :path => '/Users/vfilby/Projects/tanker' #, :git => 'git://github.com/vfilby/tanker.git'
gem 'will_paginate'
gem 'paperclip'
gem 'aws-sdk', '~> 1.3.4'
gem 'mime-types', :require => 'mime/types'
gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'omniauth', '~> 0.3.2' #, '~> 1.0'
#gem 'omniauth-openid'
#gem 'omniauth-twitter'
#gem 'omniauth-facebook'
gem 'cancan'
gem 'pg'

group :production do
  gem 'thin'
end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'sqlite3'
  #gem 'webrat'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'awesome_print'
end
