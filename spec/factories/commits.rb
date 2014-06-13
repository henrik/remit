# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commit do
    sequence(:sha) { |n| "abc#{n}" }
    payload {
      {
        author: { email: "x@y.com", username: "x", },
        message: "x",
        url: "/",
      }
    }
  end
end
