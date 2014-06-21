require "rails_helper"

describe "Authorization of user-facing pages" do
  around(:each) do |x|
    ENV["AUTH_KEY"] = "sesame"
    x.call
    ENV["AUTH_KEY"] = nil
  end

  it "authorizes you against the AUTH_KEY if present" do
    get "/"
    expect(response.code).to eq "401"

    get "/?auth_key=jafar"
    expect(response.code).to eq "401"

    get "/?auth_key=sesame"
    expect(response.code).to eq "200"
  end

  it "remembers the key in the user session" do
    get "/?auth_key=sesame"
    expect(response.code).to eq "200"

    get "/"
    expect(response.code).to eq "200"
  end

  it "kicks you out if the remembered key changes" do
    get "/?auth_key=sesame"
    expect(response.code).to eq "200"

    ENV["AUTH_KEY"] = "jafar"

    get "/"
    expect(response.code).to eq "401"
  end
end
