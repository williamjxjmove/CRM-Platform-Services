class Info
  include MongoMapper::EmbeddedDocument

  key :first_name, String
  key :last_name, String
  key :phone, String
  key :e_mail, String

  embedded_in  :tpouser
end
