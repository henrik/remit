require "rails_helper"

describe "Receiving Heroku deploys by webhook" do
  it "sends the current app version to clients" do
    expect_push "app_deployed", { version: Remit.version }

    post "/heroku_webhook", head: "cafebabe"

    expect(response).to be_success
  end

  it "authorizes you against the WEBHOOK_KEY if present" do
    ENV["WEBHOOK_KEY"] = "sesame"

    post "/heroku_webhook", head: "cafebabe"
    expect(response.code).to eq "401"

    post "/heroku_webhook?auth_key=jafar", head: "cafebabe"
    expect(response.code).to eq "401"

    post "/heroku_webhook?auth_key=sesame", head: "cafebabe"
    expect(response.code).to eq "200"

    ENV["WEBHOOK_KEY"] = nil
  end

  private

  def expect_push(event, hash)
    expect(Pusher).to receive(:trigger).with("the_channel", event, hash).and_call_original
  end
end
