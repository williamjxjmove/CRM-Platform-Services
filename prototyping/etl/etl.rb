require './sql.rb'
require 'mongo'  
require 'log4r'
include Log4r

mongo_uri = 'mongodb://localhost:27017'
db_name = 'test'
APP_NAME = "etl"
@connection = Mongo::Connection.from_uri(mongo_uri)
@db = @connection.db(db_name)
@coll = @db.collection('tpouser')

def init_logger
	# Initial setup of logger
	logger = Logger.new(APP_NAME )

	# console messages
	logger.outputters = StdoutOutputter.new(:console)

	# logfile = RollingFileOutputter
	file = "#{APP_NAME }.log"
	File.delete(file) if  File.exist?(file) && File.size(file) > 1024 * 1024
	logfile = FileOutputter.new(APP_NAME, {:filename => file, :trunc => false})
	logfile.formatter = PatternFormatter.new(:pattern => "%t [%l] %d :: %m")
	logger.add(logfile)
	logger.trace = true 
	logger.level = DEBUG
	logger
end

@log = init_logger()
@log.info("ETL Start")

results = ['aiminagent', 'garryself123'] #test
#results = TPODB.get_active_users()
results.each do |row|
	user_name = row
	user_name.downcase!
	puts "Get data for #{user_name}"
	unless TPODB.save_bi_data(@coll, user_name)
		@log.warn("Cannot get profile info for #{user_name}")
	end
end
@log.info("total active users: #{results.count}")



