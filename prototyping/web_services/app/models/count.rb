class Count
  include MongoMapper::EmbeddedDocument

  key :contacts, Integer
  key :prospects, Integer
  key :closings, Integer
  key :listings, Integer

  embedded_in  :tpouser
end
