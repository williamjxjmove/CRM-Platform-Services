class Tpouser
  include MongoMapper::Document
  
  attr_accessible :info, :count, :user

  key :user, String
  
  one :info
  one :count
  
  timestamps!

end
