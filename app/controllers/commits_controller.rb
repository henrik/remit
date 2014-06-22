# Handles updates to commits.
# Looking for the list of commits? That's JS via PagesController.

class CommitsController < UserFacingController
  def started_review
    commit = Commit.find(params[:id])
    commit.mark_as_being_reviewed_by(params[:email])
    push_event "commit_being_reviewed", commit

    render text: "OK"
  end

  def reviewed
    commit = Commit.find(params[:id])
    commit.mark_as_reviewed_by(params[:email])
    push_event "commit_reviewed", commit

    render text: "OK"
  end

  def unreviewed
    commit = Commit.find(params[:id])
    commit.mark_as_unreviewed
    push_event "commit_unreviewed", commit

    render text: "OK"
  end
end
