# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    transient do
      body "Yo."
      user_login "myusername"
      commit nil
    end

    sequence(:github_id)
    sequence(:commit_sha) { |n| commit ? commit.sha : "aaf#{n}" }

    author { build(:author, username: user_login) }

    payload {
      {
        id: github_id,
        body: body,
        commit_id: commit_sha,
        created_at: Time.now.iso8601,
        html_url: "http://example.com",
        user: {
          login: user_login,
        },
      }
    }

    json_payload {
      payload.to_json
    }
  end
end

def FactoryGirl.comment_payload(custom = {})
  attributes_for(:comment, custom).fetch(:payload)
end
