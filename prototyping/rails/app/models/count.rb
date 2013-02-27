class Count
  include MongoMapper::EmbeddedDocument

  key :contacts, Integer, :default => 0
  key :prospects, Integer, :default => 0
  key :closings, Integer, :default => 0
  key :listings, Integer, :default => 0
  
  embedded_in  :tpouser

end
