require "rails_helper"

describe "Comments page", :js do
  it "works" do
    comment = create(:comment, body: "Hello.")

    visit "/"
    click_link "Comments"

    expect(page).to have_content "Hello."
  end
end
