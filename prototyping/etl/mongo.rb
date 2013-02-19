require 'mongo'  
  
#make a connection  
db = Mongo::Connection.new.db("test")  
##db = Mongo::Connection.new("localhost").db("test")  
##db = Mongo::Connection.new("localhost", 27017).db("test")  
##list all database  
m = Mongo::Connection.new # (optional host/port args)  
m.database_names.each { |name| puts name }  
m.database_info.each { |info| puts info.inspect}  
#
##look at collections  
db.collection_names.each { |name| puts name }  
coll = db.collection("things")  
##insert a document  
#doc = {"name" => "MongoDB", "type" => "database", "count" => 1,  
#       "info" => {"x" => 203, "y" => '102'}}  
#       coll.insert(doc)  
#find the first document  
my_doc = coll.find_one()  
p my_doc  
#insert multiple documents  
#100.times { |i| coll.insert("i" => i) } 
bKeep = true
coll.remove("i" => {"$gt" => 30}) 
#count documents in a collection  
puts coll.count() 

map = "function() { emit(this.i, {count: 1}); }"
reduce_count = "function(key, values) { " +
	"var sum = 0; " +
	"values.forEach(function(f) { " +
	" sum += f.count; " +
	"}); " +
	"return {count: sum};" +
	"};"

output = coll.map_reduce(map, reduce_count,
    {
         :sort => BSON::OrderedHash.new[["count", Mongo::ASCENDING]],
         :out => {:inline => true},
         :raw => true
    }
)
p output
#use cursor to get all document  
#coll.find().each { |row| p row }  
#find documents with a query  
coll.find("i" => 31).each { |row| p row }  
coll.find("i" => {"$gt" => 97}).each { |row| p row }  
coll.find("i" => {"$gt" => 26, "$lte" => 30}).each { |row| p row }  
#query with regex  
coll.find({"name" => /ongo/}).each { |row| p row }   
#create a index   explicit "ascending"  
#coll.create_index([["i", ASCENDING]])  
