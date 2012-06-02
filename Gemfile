source 'http://rubygems.org'

gem 'rails', '3.2.3'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails', "~> 3.2.2"
  gem 'uglifier', '>= 1.0.3'
end

# Authentication and permissions
gem 'omniauth', '~> 1.0'
gem 'omniauth-openid'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'cancan'

gem 'jquery-rails', '~> 2.0.0'
gem 'json'
gem 'geocoder', :git => 'git://github.com/alexreisner/geocoder.git'
gem 'gmaps4rails'
gem 'ruby-geonames', :git => 'git://github.com/vfilby/ruby-geonames.git'
gem 'haml'
gem 'indextank'
gem 'tanker' #, :path => '/Users/vfilby/Projects/tanker' #, :git => 'git://github.com/vfilby/tanker.git'
gem 'will_paginate', '~> 3.0'
gem 'will_paginate-bootstrap', :git => 'git://github.com/nickpad/will_paginate-bootstrap.git'
gem 'paperclip', '~> 2.7'
gem 'aws-sdk', '~> 1.3.4'
gem 'mime-types', :require => 'mime/types'
gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'pg'
gem 'multi_json', '~> 1.3.4' #, :git => 'git://github.com/intridea/multi_json.git'
gem 'grape' #, :path => '/Users/vfilby/Projects/grape' #:git => 'git://github.com/intridea/grape.git'
gem 'newrelic_rpm'
gem 'delayed_job' #, :path => '/Users/vfilby/Projects/gems/delayed_job' #, :git => 'git://github.com/collectiveidea/delayed_job.git'
gem 'delayed_job_active_record'#, :git => 'git://github.com/collectiveidea/delayed_job_active_record.git'
gem 'workless', '~> 1.0.1'
gem 'twitter'
gem 'acts_as_tree_rails3'
gem 'high_voltage'

group :production do
  gem 'thin'
end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'sqlite3'
  #gem 'webrat'
  #gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'debugger'
  gem 'awesome_print'
end
