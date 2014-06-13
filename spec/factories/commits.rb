# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commit do
    ignore do
      message { "A lovely commit." }
    end

    sequence(:sha) { |n| "abc#{n}" }
    payload {
      {
        author: { email: "x@y.com", username: "x", },
        message: message,
        url: "/",
      }
    }
  end
end
