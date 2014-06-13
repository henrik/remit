# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Don't create fake data in prod.
if Rails.env.development?
  puts "* Create an example comment"
  commit_comment_payload = JSON.parse(File.read("#{Rails.root}/db/seeds/commit_comment.json"))
  Comment.create_or_update_from_payload(commit_comment_payload["comment"])

  puts "* Create an example commit"
  commit_payload = JSON.parse(File.read("#{Rails.root}/db/seeds/push.json"))
  Commit.create_or_update_from_payload(
    commit_payload["commits"].second,
    commit_payload
  )
end
