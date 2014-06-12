# Remit

**Very much a work in progress! Beware.**

A tool for commit-by-commit code review of repositories on GitHub.

More or less a rewrite of [Hubreview](https://github.com/joakimk/hubreview) to try some new things starting from a fresh slate.

## The brilliance of the name

* <b>Re</b>view com<b>mit</b>s
* Dictionary meanings like
  * "an item referred to someone for consideration"
  * "refer (a matter for decision) to an authority"
  * "send (someone) from one tribunal to another for a trial or hearing"
  * "forgive (a sin)"

## Development

Assumes you have
  * Ruby 2.1.1
  * Bundler

Run:

    bundle
    bin/rake db:setup
    bin/rails server

Visit <http://localhost:9292>

## Test

    rake

## Production

### Set the app up on Heroku

    heroku new remit-SOMETHING-UNIQUE
    heroku addons:add heroku-postgresql:dev
    heroku config:set AUTH_KEY=`ruby -rsecurerandom -e "puts SecureRandom.urlsafe_base64"`
    git push heroku master

### Configure the webhook on GitHub

In the settings for any repo you want to use this with, add a webhook.

    Payload URL:   https://remit-SOMETHING-UNIQUE.herokuapp.com/github_webhook?auth_key=MY_AUTH_KEY
    Content type:  application/json
    Let me select individual events:  [x] Push  [x] Commit comment

Where `MY_AUTH_KEY` is whatever you assigned above (see it again with `heroku config:get AUTH_KEY`).

## Idea dump

* exception logger
* Use AngularJS for the front-end! Whee!
* Store away both commits and comments via webhooks.
  * Store the raw data in one field so we can easily migrate data later.
* Three tabs: commits/comments/prefs
* Configure an email for your gravatar
* Configure a committer name substring to determine "your" commits (considering pair commits) - possibly default to using the email?
* Get websockets solid (in dev, test and prod). Maybe use an external service like Pusher?
* Show faces (Gravatars) to indicate who is currently reviewing something
  * TODO Consider the review over when you click "Reviewed" or if you click "Abandon review" or after a timeout?
* Show faces to indicate who did review something
* Show how old the oldest unreviewed commit is (with a link to review it)
* Bundle or link to a script to set up the same webhook on multiple repos?
* MAYBE: stats on how much you review. But avoid it becoming a competition.
* spec auth?
