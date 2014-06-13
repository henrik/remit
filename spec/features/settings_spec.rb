require "rails_helper"

describe "Settings page", :js do
  it "works" do
    visit "/"
    click_link "Settings"

    # Nothing interesting to test yet
    expect(page).to have_content "settings! :)"
  end
end
