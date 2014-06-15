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
        id: github_id,
        body: body,
        commit_id: commit_sha,
        user: {
          login: user_login,
        },
      }
    }
  end
end

def FactoryGirl.comment_payload(custom = {})
  attributes_for(:comment, custom).fetch(:payload)
end
