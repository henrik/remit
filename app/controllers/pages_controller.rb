class PagesController < ApplicationController
  NUMBER_OF_COMMENTS = 250
  NUMBER_OF_COMMITS  = 250

  def index
    @comments = Comment.newest_first.last(NUMBER_OF_COMMENTS)
    @commits  = Commit.newest_first.last(NUMBER_OF_COMMITS)
  end
end
