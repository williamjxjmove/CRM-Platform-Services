require 'rest_client'
require 'json'
require 'benchmark'

def lookup_server()
	key =  ARGV.first  || 'local'
	serverList = {	"dev11" =>  "https://tpodev11-8i.corp.homestore.net/Notification",
			"itgn" => "https://sms-itgn.topproduceronline.com",
			"sqan" => "https://sms-sqan.topproduceronline.com", 
			"stag" => "https://sms-staging.topproduceronline.com",
			"prod" => "https://sms-service.realtor.com",
			"dev10" => "http://tpodev10web01.tpolab.com:38570",
			"local" => "http://localhost:4567"
	}
	serverList[key] 
end

def time_watch_call(url)
	puts url
	time_before = Time.now
	response = RestClient.get url
	puts response.body
	puts (Time.now - time_before) * 1000 
end

login_name = 'aiminagent'
url_mongo = "#{lookup_server()}/mongo/#{login_name}"
url_sql = "#{lookup_server()}/sql/#{login_name}"

Benchmark.bmbm(8) do |b|
  b.report("MONGO:")    { RestClient.get(url_mongo) }
  b.report("SQL:") 		{ RestClient.get(url_sql) }
end

time_watch_call(url_mongo)
time_watch_call(url_sql)
