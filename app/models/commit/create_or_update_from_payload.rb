class Commit
  class CreateOrUpdateFromPayload
    method_object :call,
      :commit_payload, :push_payload

    def call
      commit = find_or_initialize
      commit.payload = payload
      commit.author = create_or_update_author
      commit.save!
      commit
    end

    private

    def find_or_initialize
      Commit.where(sha: payload.fetch(:id)).first_or_initialize
    end

    def create_or_update_author
      Author.create_or_update_from_payload(author_payload)
    end

    def payload
      commit_payload.merge(
        repository: push_payload.fetch(:repository),
      )
    end

    def author_payload
      commit_payload.fetch(:author)
    end

    def commit_payload
      @commit_payload.deep_symbolize_keys
    end

    def push_payload
      @push_payload.deep_symbolize_keys
    end
  end
end
