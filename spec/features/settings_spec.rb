require "rails_helper"

describe "Settings page", :js do
  it "lets you store your name" do
    commit = create(:commit, author_name: "Ada Lovelace and Charles Babbage")

    visit_and_init_message_bus "/"

    click_link "Commits"
    expect(page).not_to have_selector(".authored-by-you")

    click_link "Settings"
    fill_in "Your name", with: "Ada Lovelace"
    fill_in "Your email", with: "ada@lovelace.com"

    click_link "Commits"
    expect(page).to have_selector(".authored-by-you")

    click_link "Settings"
    expect(find_field("Your name").value).to eq "Ada Lovelace"
    expect(find_field("Your email").value).to eq "ada@lovelace.com"
  end
end
