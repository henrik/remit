require "rails_helper"

describe "Commits page", :js do
  it "works" do
    # url is "/" since we'll click the link later, and we want a local
    # path that exists.
    commit = create(:commit, sha: "cafebabe", url: "/")

    visit "/"
    click_link "Commits"

    expect(page).to have_content "cafebabe"

    # Marks it as clicked.
    expect(page).not_to have_selector(".your-last-clicked-commit")
    click_link "cafebabe"
    expect(page).to have_selector(".your-last-clicked-commit")
  end
end
