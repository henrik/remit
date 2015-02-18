class Comment
  class CreateOrUpdateFromPayload
    method_object :call,
      :payload

    def call
      comment = find_or_initialize
      comment.commit_sha = payload.fetch(:commit_id)
      comment.payload = payload
      comment.author = create_or_update_author
      comment.save!
      comment
    end

    private

    def find_or_initialize
      Comment.where(github_id: payload.fetch(:id)).first_or_initialize
    end

    def create_or_update_author
      Author.create_or_update_from_payload(author_payload)
    end

    def author_payload
      {
        # This is the only attribute we get.
        username: payload.fetch(:user).fetch(:login),
      }
    end

    def payload
      @payload.deep_symbolize_keys
    end
  end
end
