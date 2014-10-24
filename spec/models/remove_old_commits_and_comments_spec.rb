require "rails_helper"

describe RemoveOldCommitsAndComments, ".beyond_the_first_n_commits" do
  it "removes only commits beyond the first n, and their associated comments" do
    # These commits, the oldest ones, should be removed.

    commit_1 = create(:commit)

    commit_2 = create(:commit)
    comment_2_a = create(:comment, commit: commit_2)
    comment_2_b = create(:comment, commit: commit_2)
    comment_2_c = create(:comment, commit: commit_2)

    commit_3 = create(:commit)
    comment_3 = create(:comment, commit: commit_3)

    # This commit, the latest one, should not be removed.

    commit_4 = create(:commit)
    comment_4_a = create(:comment, commit: commit_4)
    comment_4_b = create(:comment, commit: commit_4)

    message = RemoveOldCommitsAndComments.beyond_the_first_n_commits(1)

    expect(Commit.all).to match_array [ commit_4 ]
    expect(Comment.all).to match_array [ comment_4_a, comment_4_b ]

    expect(message).to eq "Deleted 3 commit(s) and 4 comment(s)."
  end
end
