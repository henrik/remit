require "rails_helper"

describe "Comments page", :js do
  it "works for simultaneous visitors" do
    comment = create(:comment, body: "Hello.")

    visitors :ada, :charles do
      visit_and_wait_for_message_bus_init "/"
      click_link "Comments"
      expect(page).to have_content "Hello."
    end

    visitor :ada do
      configure_settings email: "ada@lovelace.com"
      visit_and_wait_for_message_bus_init "/comments"

      comment_looks_new
      click_button "Mark as resolved"
      comment_looks_resolved
    end

    verify_that_comment_is_persisted_as_resolved_by_ada

    visitor :charles do
      # Charles sees that Ada marked it it.
      comment_looks_resolved

      # Charles marks it as new.
      click_button "Mark as new"
      comment_looks_new
    end

    visitor :ada do
      # Ada sees that Charles marked it as new again.
      comment_looks_new
    end
  end

  private

  def verify_that_comment_is_persisted_as_resolved_by_ada
    wait_for_non_dom_ajax_to_complete
    comment = Comment.last!
    expect(comment).to be_resolved
    expect(comment.resolved_by_author.email).to eq "ada@lovelace.com"
  end

  def comment_looks_resolved
    expect(page).to have_selector(".is-resolved")
  end

  def comment_looks_new
    expect(page).not_to have_selector(".is-resolved")
  end
end
