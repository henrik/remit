# Handles updates to commits.
# Looking for the list of commits? That's JS via PagesController.

class CommitsController < UserFacingController
  def reviewed
    id = params[:id].to_i

    Commit.find(id).mark_as_reviewed
    push_event "commit_reviewed", id: id

    render text: "OK"
  end

  def unreviewed
    id = params[:id].to_i

    Commit.find(id).mark_as_unreviewed
    push_event "commit_unreviewed", id: id

    render text: "OK"
  end
end
