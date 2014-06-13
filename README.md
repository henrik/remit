# Remit

**Very much a work in progress! Beware.**

A tool for commit-by-commit code review of repositories on GitHub.

More or less a rewrite of [Hubreview](https://github.com/joakimk/hubreview) to try some new things starting from a fresh slate.

## The brilliance of the name

* <b>Re</b>view com<b>mit</b>s
* Dictionary meanings like
  * "an item referred to someone for consideration"
  * "forgive (a sin)"

## Development

Assumes you have
  * Ruby 2.1.2
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
    heroku config:set AUTH_KEY=`ruby -rsecurerandom -e "puts SecureRandom.urlsafe_base64"` SECRET_KEY_BASE=`rake secret`
    git push heroku master

### Configure the webhook on GitHub

Working at [Barsoom](http://barsoom.se)? [We've got you covered.](https://github.com/barsoom/servers/wiki/Automatically-apply-webhooks-to-all-our-repos)

Not so fortunate? In the settings for any repo you want to use this with, add a webhook:

    Payload URL:   https://remit-SOMETHING-UNIQUE.herokuapp.com/github_webhook?auth_key=MY_AUTH_KEY
    Content type:  application/json
    Let me select individual events:  [x] Push  [x] Commit comment

Where `MY_AUTH_KEY` is whatever you assigned above (see it again with `heroku config:get AUTH_KEY`).
