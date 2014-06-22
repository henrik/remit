require "rails_helper"

describe "Commits page", :js do
  it "works for simultaneous visitors" do
    create(:commit, message: "Compute Bernoulli numbers.", url: "/")  # URL is "/" so clicking a commit brings us back.

    visitors :ada, :charles do
      visit "/"
      expect(page).to have_content "Compute Bernoulli numbers."
    end

    visitor :ada do
      configure_settings

      commit_looks_new
      click_button "Start review"
      commit_looks_pending
    end

    visitor :charles do
      commit_looks_pending
    end

    visitor :ada do
      click_button "Abandon review"
      commit_looks_new
    end

    visitor :charles do
      commit_looks_new
    end

    visitor :ada do
      click_button "Start review"
      click_button "Mark as reviewed"
      commit_looks_reviewed
    end

    verify_that_commit_is_persisted_as_reviewed_by_ada

    visitor :charles do
      # Charles sees that Ada reviewed it.
      commit_looks_reviewed

      # Charles marks it as new.
      click_button "Mark as new"
      commit_looks_new
    end

    visitor :ada do
      # Ada sees that Charles marked it as new again.
      commit_looks_new
    end
  end

  private

  def visitors(*names, &block)
    names.each do |name|
      visitor(name, &block)
    end
  end

  def configure_settings
    visit "/settings"
    fill_in "Your email", with: "ada@lovelace.com"
    visit "/"
  end

  def verify_that_commit_is_persisted_as_reviewed_by_ada
    sleep 0.1  # FIXME: :/ Waiting for non-DOM Ajax to complete.
    commit = Commit.last!
    expect(commit).to be_reviewed
    expect(commit.reviewed_by_author.email).to eq "ada@lovelace.com"
  end

  def commit_looks_reviewed
    expect(page).to have_selector(".is-reviewed")
  end

  def commit_looks_pending
    expect(page).to have_selector(".is-being-reviewed")
  end

  def commit_looks_new
    expect(page).not_to have_selector(".is-reviewed, .is-being-reviewed")
  end

  # http://blog.bruzilla.com/post/20889863144/using-multiple-capybara-sessions-in-rspec-request-specs
  def visitor(name)
    old_session = Capybara.session_name
    Capybara.session_name = name
    yield
    Capybara.session_name = old_session
  end
end
