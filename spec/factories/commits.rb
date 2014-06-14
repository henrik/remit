# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commit do
    ignore do
      message "A lovely commit."
      url "http://example.com"
      author_username { [ nil, "fakeuser" ].sample }  # Empty for pair commits
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
          name: "Commit Author",
        },
        ref: ref,
        repository: { name: "myrepo" },
        pusher: { name: "Commit Pusher" },
      }
    }
  end
end

def FactoryGirl.commit_payload(custom = {})
  attributes_for(:commit, custom).fetch(:payload)
end
