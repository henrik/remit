class Author
  class CreateOrUpdateFromPayload
    method_object :call,
      :payload

    def call
      author = find_or_initialize
      author.name = name if name
      author.email = email if email
      author.username = username if username
      author.save!
      author
    end

    private

    def find_or_initialize
      Author.
        where("email = ? OR username = ?", email, username).
        first_or_initialize
    end

    def name
      payload[:name]
    end

    def email
      payload[:email]
    end

    def username
      payload[:username]
    end

    def payload
      @payload.deep_symbolize_keys
    end
  end
end
