# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commit do
    ignore do
      message { Faker::Company.catch_phrase }
      url "http://example.com"
      author_username { [ nil, Faker::Internet.user_name ].sample }  # Empty for pair commits
      author_name { Faker::Name.name }
      ref "refs/heads/master"
    end

    sha { SecureRandom.hex(20) }
    payload {
      {
        id: sha,
        message: message,
        url: url,
        author: {
          email: "mymail@example.com",
          username: author_username,
          name: author_name,
        },
        ref: ref,
        repository: { name: "myrepo" },
        pusher: { name: Faker::Name.name },
      }
    }
  end
end

def FactoryGirl.commit_payload(custom = {})
  attributes_for(:commit, custom).fetch(:payload)
end
