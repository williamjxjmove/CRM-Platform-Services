class Tpouser
  include MongoMapper::Document

  key :v, Integer
  key :UserId, String
  key :ProfileId, String
  key :Day1, Date
  key :New1, Integer
  key :Total1, Integer

end
