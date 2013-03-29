# Platform Services API

The Top Producer CRM Platform Services API provides a reusable service framework for internal and externally accessible
applications to leverage the CRM components.

Code developed and maintained by [Top Producer Development Team](mailto://#8iDevTeam@move.com).


# 14.3
## steps

    $ rails new gs_14_3
    $ cd gs_14_3

    $ rails generate scaffold tpouser v:Integer UserId:string ProfileId:string Day1:Date New1:Integer Total1:Integer --skip-migration  --orm mongo_mapper
    $ 


## Gemfile:
<pre>
source 'https://rubygems.org'

require 'mongo'

gem 'rails', '3.2.13'
gem 'bootstrap-sass', '2.1'
gem 'bcrypt-ruby', '3.0.1'
gem 'faker', '1.0.1'
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'


# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.11.0'
  gem 'guard-rspec', '1.2.1'

  gem 'guard-spork', :github => 'guard/guard-spork'
  # gem 'guard-spork', '1.2.0'
  gem 'spork', '0.9.2'

  gem 'mongo_mapper', '~> 0.12.0'
  gem 'bson_ext', '~> 1.8.2'
  gem 'bson', '~> 1.8.2'
  gem 'mongo', '~> 1.8.2'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development do
  gem 'annotate', '2.5.0'
  gem 'mongo_mapper', '~> 0.12.0'
  gem 'bson_ext', '~> 1.8.2'
  gem 'bson', '~> 1.8.2'
  gem 'mongo', '~> 1.8.2'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'rb-inotify', '~> 0.9'
  gem 'libnotify', '0.5.9'
  # not work, still keeping.
  gem 'childprocess', '~> 0.3.9'
  gem 'factory_girl_rails', '4.1.0'
end

</pre>


## config/routes.rb

    match '/v1/user/contacts/count/createdInDateRange/:login/:startDate/:endDate'=>'tpousers#contacts_in_range'
    match '/v1/user/contacts/count/createdForMonth/:login/:month' => 'tpousers#contacts_6month'
    match '/v1/user/contacts/count/:login' => 'tpousers#total_number'


## Generic commands:

    $ cd gs_14_3
    $ guard start
    $ rails console test
    $ mmconsole
    $ rspec spec/
    $ rspec spec/requests/user_pages_spec.rb
    $ rspec spec/models/tpouser_spec.rb
    $ rspec spec/controller/controllers
    $ rails generate rspec:install
    $ rails generate cucumber:install
    $ ...
