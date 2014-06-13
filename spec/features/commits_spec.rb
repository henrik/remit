require "rails_helper"

describe "Commits page", :js do
  it "works" do
    commit = create(:commit, sha: "cafebabe")

    visit "/"
    click_link "Commits"

    expect(page).to have_content "cafebabe"

    # Marks it as clicked.
    expect(page).not_to have_selector(".your-last-clicked-commit")
    click_link "cafebabe"
    expect(page).to have_selector(".your-last-clicked-commit")
  end
end
