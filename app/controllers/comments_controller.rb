# Handles updates to comments.
# Looking for the list of comments? That's PagesController.

class CommentsController < UsersBaseController
  def resolved
    comment.mark_as_resolved_by(email)
    render_and_push_event "comment_resolved"
  end

  def unresolved
    comment.mark_as_unresolved
    render_and_push_event "comment_unresolved"
  end

  private

  def render_and_push_event(name)
    push_event name, comment: comment, email: email
    render text: "OK"
  end

  def comment
    @comment ||= Comment.find(params[:id])
  end

  def email
    params[:email]
  end
end
