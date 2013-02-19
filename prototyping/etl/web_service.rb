require 'sinatra'
require 'mongo' 
require 'json'
require './sql.rb'

configure do
	CONN = Mongo::Connection.new
	DB = 'test'
end

def scoped_collection()
	CONN[DB]['tpouser']
end

def get_mongo_data(user_name)
	scoped_collection.find({TPODB.get_mongo_primary_key  => user_name}, :fields => { :_id => false})
end

get '/sql/:name' do |n|
	content_type :json
		TPODB.get_bi_data(n).to_json
end

get '/mongo/:name' do |n|
	n.downcase!
	row = get_mongo_data(n)
	if row.count == 0
		TPODB.save_bi_data(scoped_collection, n)
		row = get_mongo_data(n)
	end

	content_type :json
		row.to_a.to_json
end