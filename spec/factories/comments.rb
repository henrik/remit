# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    ignore do
      body "Yo."
      user_login "myusername"
    end

    sequence(:github_id)
    sequence(:commit_sha) { |n| "aaf#{n}" }

    payload {
      {
        user: {
          login: user_login,
        },
        body: body,
      }
    }
  end
end
