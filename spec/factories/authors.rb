# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :author do
    username { Faker::Internet.user_name }
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end
