# Schedule this, e.g. with
# https://devcenter.heroku.com/articles/scheduler
# to clean up old data, if you're running out of DB space:
#
#   # Add the scheduler addon:
#   heroku addons:add scheduler:standard
#
#   # Open its UI:
#   heroku addons:open scheduler
#
#   # Schedule this:
#   rails runner "puts RemoveOldCommitsAndComments.beyond_the_first_n_commits(1000)"
#
# Change the number as you see fit, of course.

class RemoveOldCommitsAndComments
  def self.beyond_the_first_n_commits(offset)
    commit_shas_to_remove = Commit.newest_first.offset(offset).pluck(:sha)

    commit_count = Commit.where(sha: commit_shas_to_remove).delete_all
    comment_count = Comment.where(commit_sha: commit_shas_to_remove).delete_all

    "Deleted #{commit_count} commit(s) and #{comment_count} comment(s)."
  end
end
