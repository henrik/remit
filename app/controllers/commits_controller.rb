# Handles updates to commits.
# Looking for the list of commits? That's PagesController.

class CommitsController < UsersBaseController
  def started_review
    commit.mark_as_being_reviewed_by(email)
    render_and_push_event "commit_being_reviewed"
  end

  def reviewed
    commit.mark_as_reviewed_by(email)
    render_and_push_event "commit_reviewed"
  end

  def unreviewed
    commit.mark_as_unreviewed
    render_and_push_event "commit_unreviewed"
  end

  private

  def render_and_push_event(name)
    push_event name, commit: commit, email: email
    render text: "OK"
  end

  def commit
    @commit ||= Commit.find(params[:id])
  end

  def email
    params[:email]
  end
end
