# Goal Settings Web Service

## Features:

Default port is <strong>3001</strong>.

1. Can search by different fields/columns:

<ul>
<li> ID </li>
<li> User </li>
<li> Phone </li>
<li> E-mail </li>
<li> First Nam </li>
<li> Last Nam </li>
<li> ... ... </li>
</ul>

2. Can search multi-records, such as fname = 'first'

3. can be used in browser and command-line like 'curl', 'wget' etc.

4. The web-service works in 10.185.20.184:3001, work with http://10.185.20.184:3000/tpousers/ which is a CRUD interface.

## Usage:

$ cd _ _ HERE _ _

$ bundle install (su to root if needed)

$ rails server


$ In browser:

(1) http://localhost:3001/phone/123456789.json 

(2) http://localhost:3001/user/williamjxj

(3) http://localhost:3001/fname/first

(4) http://localhost:3001/lname/last.json 

## keys:

$ rails new webservice --skip-active-record

$ vi rest/Gemfile:

require 'mongo'
  gem 'mongo_mapper', '~> 0.12.0'
  gem 'bson_ext', '~> 1.8.2'
  gem 'bson', '~> 1.8.2'
  gem 'mongo', '~> 1.8.2'


$ bundle install

$ vi config/initializers/mongo_config.rb:

MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "test"
 
if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
  MongoMapper.connection.connect if forked
   end
end



$ vi script/rails # change port number t 3001

require "rails/commands/server"
module Rails
  class Server
    def default_options
      super.merge({
        :Port        => 3001,
        :environment => (ENV['RAILS_ENV'] || "development").dup,
        :daemonize   => false,
        :debugger    => false,
        :pid         => File.expand_path("tmp/pids/server.pid"),
        :config      => File.expand_path("config.ru")
      })
    end
  end
end



$ rails generate scaffold tpouser user:string --skip-migration --orm mongo_mapper

$ rails generate model Info  first_name:string last_name:string phone:string e_mail:string --skip-migration --orm mongo_mapper

$ rails generate model Count contacts:Integer prospects:Integer closings:Integer listings:Integer --skip-migration --orm mongo_mapper


$ do coding...

