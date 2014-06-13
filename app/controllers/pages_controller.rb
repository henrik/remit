class PagesController < ApplicationController
  NUMBER_OF_COMMENTS = 250
  NUMBER_OF_COMMITS  = 250

  def index
    render locals: {
      comments: Comment.newest_first.include_commits.last(NUMBER_OF_COMMENTS),
      commits: Commit.newest_first.last(NUMBER_OF_COMMITS),
    }
  end
end
