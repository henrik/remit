class PagesController < ApplicationController
  NUMBER_OF_COMMENTS = 250
  NUMBER_OF_COMMITS  = 250

  def index
    render locals: {
      comments: Comment.newest_first.include_commits.last(NUMBER_OF_COMMENTS),
      commits: Commit.newest_first.last(NUMBER_OF_COMMITS),
    }
  end

  private

  def require_auth_key
    return unless production?

    expected_key = ENV["AUTH_KEY"]

    raise "AUTH_KEY must be configured in production. Please see README." unless expected_key

    # Remember auth key in the session so you don't have to provide it with every single request.
    # A changed expected key will expire your session.
    if session[:auth_key] == expected_key || params[:auth_key] == expected_key
      session[:auth_key] = expected_key
    else
      render status: 401, text: "Not authorized! Did you forget to provide auth_key in the URL?"
    end
  end
end
