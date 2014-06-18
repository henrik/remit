# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commit do
    ignore do
      message { Faker::Company.catch_phrase }
      url "http://example.com"
      author_email { "mymail@example.com" }
      author_username { [ nil, Faker::Internet.user_name ].sample }  # Empty for pair commits
      author_name { Faker::Name.name }
    end

    sha { SecureRandom.hex(20) }

    author {
      build(:author,
        email: author_email,
        username: author_username,
        name: author_name)
    }

    payload {
      {
        id: sha,
        message: message,
        url: url,
        timestamp: Time.now.iso8601,
        author: {
          email: author_email,
          username: author_username,
          name: author_name,
        },
        repository: { name: "myrepo" },
      }
    }
  end
end

def FactoryGirl.commit_payload(custom = {})
  attributes_for(:commit, custom).fetch(:payload)
end
