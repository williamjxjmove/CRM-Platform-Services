require "tiny_tds"  

class TPODB
	@@user = 'bll_dev'
	@@pwd = 'dev_test' 
	@@profile_db_server = 'daz02sql300'	
	@@profile_db_client = TinyTds::Client.new(:username => @@user, :password => @@pwd, \
				:host => @@profile_db_server, :database => 'profile')	
	MONGO_PRIMARY_KEY  = 'user'
	
	def self.get_mongo_primary_key()
		MONGO_PRIMARY_KEY
	end
	
	def self.get_client(db_server, db_name)
		TinyTds::Client.new(:username => @@user, :password => @@pwd, :host => db_server, :database => db_name)
	end

	def self.get_agent_db(database_id)
		row = @@profile_db_client.execute("select top 1 db_server_name from databases with (nolock) \
		  where database_id = #{database_id}").first
		row['db_server_name']
	end

	def self.get_user_info (use_name)
		sql = "select top 1 p.profile_id, u.user_id,  p.database_id, first_name, last_name, work_phone, e_mail 
		from  users_to_profiles up with (nolock) inner join users u  with (nolock) on u.user_id = up.user_id 
		inner join profiles p with (nolock) on p.profile_id = up.profile_id and p.account_id =  u.account_id  
		where u.login_name = '#{use_name}'"
		@@profile_db_client.execute(sql).first
	end

	def self.get_count(client, sql)
			row = client.execute(sql).first
			row[''] || 0
	end

	def self.get_sql(key, profile_id, user_id)
		sql_list = {	
			"c.p" =>  "select count(*) from contacts with (nolock) where profile_id = '#{profile_id}' and access_mode < 2",
			"a.u" =>  "select count(*) from activities with (nolock) where profile_id = '#{profile_id}' and assigned_to_id = '#{user_id}' 
			      and is_done = 1 and today_business_type_id in (1,2)",
			"cl.p" => "select count(*) from closings with (nolock) where profile_id = '#{profile_id}'"
		}
		sql_list[key] 
	end

	def self.get_active_users()
		sql = 'select u.login_name from profile.dbo.users u with (nolock)
			inner join accounts a with (nolock) on u.user_id = a.owner_id
			where a.account_status_id = 2  and a.account_type_id in (1,2,4)'
		results = @@profile_db_client.execute(sql)
		login_names = results.collect { |row| row["login_name"] }
		results.do 
		login_names
	end

	def self.get_bi_data(user_name)
		user_name.downcase!
		row = get_user_info(user_name)
		return {MONGO_PRIMARY_KEY => user_name, "count" => {}} if row.nil?
		
		profile_id =  row['profile_id'] 	
		user_id = row['user_id']
		agent_db = get_agent_db(row['database_id'])
		client = get_client(agent_db, 'agent')

		contacts_num = get_count(client, get_sql('c.p', profile_id, user_id))
		prospects_num = get_count(client, get_sql('a.u', profile_id, user_id))
		closings_num = 0
		
		 {MONGO_PRIMARY_KEY=> user_name, 'info' => {'first_name' => row['first_name'], \
		   'last_name' => row['last_name'], 'phone' => row['work_phone'], 'e_mail' => row['e_mail']}, \
		   'count' => {'contacts' => contacts_num, 'prospects' => prospects_num, 'closings' => closings_num}}
	end
	
	def self.save_bi_data(coll, user_name)
		doc = get_bi_data(user_name) 
		return false if doc['count'].empty? #invalid account??

		coll.update({MONGO_PRIMARY_KEY => user_name}, \
			{'$set' => {'info' => doc['info'], 'count' => doc['count']}},  \
			{:upsert  => true}) 
		true
	end	
end
