require "rails_helper"

describe "GET /api/v1/unreviewed_commits" do
  it "provides info about unreviewed commits" do
    # Oldest, but reviewed.
    create(:commit, :reviewed, payload: { timestamp: "2015-01-01T12:00:00Z" })

    # Newest unreviewed.
    create(:commit, :unreviewed, payload: { timestamp: "2015-01-01T14:00:00Z" })

    # Oldest unreviewed.
    create(:commit, :unreviewed, payload: { timestamp: "2015-01-01T13:00:00Z" })

    get "/api/v1/unreviewed_commits"

    expect(response).to be_success

    expect(parsed_response).to include(
      "count" => 2,
      "oldest_timestamp" => "2015-01-01T13:00:00Z",
    )
  end

  it "includes the oldest_age_in_seconds" do
    timestamp = 1.minute.ago

    create(:commit, :unreviewed, payload: { timestamp: timestamp.iso8601 })

    get "/api/v1/unreviewed_commits"

    expect(response).to be_success

    expect(parsed_response["oldest_age_in_seconds"]).to be_within(10).of(60)
  end

  it "handles 0 unreviewed commits" do
    get "/api/v1/unreviewed_commits"

    expect(response).to be_success

    expect(parsed_response).to eq(
      "count" => 0,
      "oldest_timestamp" => nil,
      "oldest_age_in_seconds" => nil,
    )
  end

  def parsed_response
    JSON.parse(response.body)
  end
end
