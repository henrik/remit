# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commit do
    ignore do
      message "A lovely commit."
      url "http://example.com"
    end

    sequence(:sha) { |n| "abc#{n}" }
    payload {
      {
        id: sha,
        message: message,
        url: url,
        author: {
          email: "mymail@example.com",
          username: "myusername",
        },
      }
    }
  end
end
