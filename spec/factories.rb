FactoryGirl.define do
  factory :user do
    name                        "Mike Linde"
    email                       "mike.linde@move.com"
    password                    "foobar"
    password_confirmation       "foobar"
  end
end