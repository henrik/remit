# Handles updates to commits.
# Looking for the list of commits? That's JS via PagesController.

class CommitsController < UserFacingController
  def started_review
    commit.mark_as_being_reviewed_by(email)
    push_event "commit_being_reviewed", commit: commit, email: email

    render text: "OK"
  end

  def reviewed
    commit.mark_as_reviewed_by(email)
    push_event "commit_reviewed", commit: commit, email: email

    render text: "OK"
  end

  def unreviewed
    Rails.logger.debug "unreviewed!! email #{email.inspect}, params #{params.inspect}"
    commit.mark_as_unreviewed
    push_event "commit_unreviewed", commit: commit, email: email

    render text: "OK"
  end

  private

  def commit
    @commit ||= Commit.find(params[:id])
  end

  def email
    params[:email]
  end
end
