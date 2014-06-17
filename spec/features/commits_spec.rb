require "rails_helper"

describe "Commits page", :js do
  it "works for simultaneous visitors" do
    create(:commit, sha: "cafebabe", url: "/")  # URL is "/" so clicking a commit brings us back.

    visitors :ada, :charles do
      visit "/"
      expect(page).to have_content "cafebabe"
    end

    visitor :ada do
      commit_becomes_marked_as_last_clicked do
        click_link "cafebabe"
      end

      # Ada marks it as reviewed.
      commit_does_not_look_reviewed
      click_button "Mark as reviewed"
      commit_looks_reviewed
    end

    commit_is_marked_as_reviewed_in_db

    visitor :charles do
      # Charles sees that Ada reviewed it.
      commit_looks_reviewed

      # Charles marks it as new.
      click_button "Mark as new"
      commit_does_not_look_reviewed
    end

    visitor :ada do
      # Ada sees that Charles marked it as new again.
      commit_does_not_look_reviewed
    end
  end

  private

  def visitors(*names, &block)
    names.each do |name|
      visitor(name, &block)
    end
  end

  def commit_becomes_marked_as_last_clicked
    expect(page).not_to have_selector(".your-last-clicked-commit")
    yield
    expect(page).to have_selector(".your-last-clicked-commit")
  end

  def commit_is_marked_as_reviewed_in_db
    sleep 0.1  # FIXME: :/ Waiting for non-DOM Ajax to complete.
    commit = Commit.last!
    expect(commit).to be_reviewed
  end

  def commit_looks_reviewed
    expect(page).to have_selector(".is-reviewed")
  end

  def commit_does_not_look_reviewed
    expect(page).not_to have_selector(".is-reviewed")
  end

  # http://blog.bruzilla.com/post/20889863144/using-multiple-capybara-sessions-in-rspec-request-specs
  def visitor(name)
    old_session = Capybara.session_name
    Capybara.session_name = name
    yield
    Capybara.session_name = old_session
  end
end
