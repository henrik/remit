require "rails_helper"

describe "Commits page", :js do
  it "works" do
    # url is "/" since we'll click the link later, and we want a local
    # path that exists.
    commit = create(:commit, sha: "cafebabe", url: "/")

    in_browser(:one) do
      visit "/"
      click_link "Commits"

      expect(page).to have_content "cafebabe"
    end

    in_browser(:two) do
      visit "/"
      click_link "Commits"

      expect(page).to have_content "cafebabe"
    end

    in_browser(:one) do
      # Marks as last clicked.
      expect(page).not_to have_selector(".your-last-clicked-commit")
      click_link "cafebabe"
      expect(page).to have_selector(".your-last-clicked-commit")

      # Marks as reviewed.
      expect_commit_not_to_look_reviewed
      click_button "Mark as reviewed"
      expect_commit_to_look_reviewed
    end

    # Should be persisted in DB.
    sleep 0.1  # FIXME: :/ Waiting for non-DOM Ajax to complete.
    commit.reload
    expect(commit).to be_reviewed

    in_browser(:two) do
      # User two sees it as reviewed.
      expect_commit_to_look_reviewed

      # Mark as new again.
      click_button "Mark as new"
      expect_commit_not_to_look_reviewed
    end

    in_browser(:one) do
      # User one sees it as no longer reviewed.
      expect_commit_not_to_look_reviewed
    end
  end

  private

  def expect_commit_to_look_reviewed
    expect(page).to have_selector(".is-reviewed")
  end

  def expect_commit_not_to_look_reviewed
    expect(page).not_to have_selector(".is-reviewed")
  end

  # http://blog.bruzilla.com/post/20889863144/using-multiple-capybara-sessions-in-rspec-request-specs
  def in_browser(name)
    old_session = Capybara.session_name
    Capybara.session_name = name
    yield
    Capybara.session_name = old_session
  end
end
