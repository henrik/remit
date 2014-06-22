**Status: rough around the edges but usable. [See outstanding issues.](https://github.com/henrik/remit/issues)**

<img src="https://github.com/henrik/remit/raw/master/app/assets/images/favicon.png" alt="" height="150">

**Remit** is a web app for commit-by-commit code review of GitHub repositories. A modern, live UI thanks to AngularJS and WebSockets.

It's super easy to set up on a free Heroku instance.

Keeps track of what has been reviewed and links to GitHub commits for the actual review.

Also tracks comments on commits.

### Demo

Review the Remit commits using Remit:

<https://remit-on-remit.herokuapp.com/?auth_key=demo>

Please keep in mind that it's meant to be [used within Fluid.app](#use-with-fluidapp) so you get a GitHub panel on the side.

### Why commit-by-commit review?

If you think truly continuous integration and delivery (perhaps with feature flags) is important, you may prefer not to work with pull requests as a rule.

If you don't work with pull requests, commit-by-commit review is what you get. It has some benefits and some downsides compared to review by pull request.

Read more in this blog post: ["The risks of feature branches and pre-merge code review"](http://thepugautomatic.com/2014/02/code-review/).

### The name

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
    cp config/initializers/pusher.rb{.template,}
    # Configure for development per https://devcenter.heroku.com/articles/pusher
    vim config/initializers/pusher.rb
    bin/rails server

Visit <http://localhost:9292>

### Fake incoming webhooks

    rake dev:commits N=3   # 3 new commits from GitHub
    rake dev:comments N=3  # 3 new comments from GitHub
    rake dev:deploy        # Heroku says it deployed

### Import a production DB into dev

    heroku addons:add pgbackups:auto-month  # Free
    rake dev:db

You may need to exit Rails consoles and servers to avoid an error about DB being in use.

### See what a full payload looks like

See `db/seeds/push.json` (commits) and `db/seeds/commit_comment.json` (comments).


## Test

    # Full suite
    rake

    # Only Ruby tests, skip JS unit tests
    rake spec

    # Only JS unit tests (Jasmine in a headless browser)
    # Yes, you need to provide the RAILS_ENV: https://github.com/searls/jasmine-rails/issues/121
    RAILS_ENV=test rake spec:javascript

    # The same JS unit tests in a headful browser
    # Assumes you've started a dev server with bin/rails server
    open http://localhost:3000/specs


## Production

### Set the app up on Heroku

    heroku new remit-SOMETHING-UNIQUE

    heroku config:set AUTH_KEY=`ruby -rsecurerandom -e "puts SecureRandom.urlsafe_base64"` WEBHOOK_KEY=`ruby -rsecurerandom -e "puts SecureRandom.urlsafe_base64"` SECRET_KEY_BASE=`rake secret`

    # DB. Free plan with max 10,000 rows.
    heroku addons:add heroku-postgresql:dev

    # For WebSockets. Free plan with 20 concurrents, 100,000 messages/month. https://addons.heroku.com/pusher
    heroku addons:add pusher

    heroku addons:add deployhooks:http --url=https://remit-SOMETHING-UNIQUE.herokuapp.com/heroku_webhook?auth_key=MY_WEBHOOK_KEY

    git push heroku master
    heroku run rake db:schema:load

If you want to use [Honeybadger](https://www.honeybadger.io) for exception tracking, also do

    heroku config:set HONEYBADGER_API_KEY=your_key

### Configure the webhook on GitHub

Working at [Barsoom](http://barsoom.se)? [We've got you covered.](https://github.com/barsoom/servers/wiki/Automatically-apply-webhooks-to-all-our-repos)

Not so fortunate? In the settings for any repo you want to use this with, add a webhook:

    Payload URL:   https://remit-SOMETHING-UNIQUE.herokuapp.com/github_webhook?auth_key=MY_WEBHOOK_KEY
    Content type:  application/json
    Let me select individual events:  [x] Push  [x] Commit comment

Where `MY_WEBHOOK_KEY` is whatever you assigned above (see it again with `heroku config:get WEBHOOK_KEY`).

### Reload clients automatically

To reload clients automatically when you deploy to Heroku, change the version number in `config/application.rb`.

If you've set up a Heroku deploy webhook per the instructions above, it will be called after deploy and generate a Pusher WebSocket message with the new version number. That message causes clients to reload if they're running a different version.

### Import reviewed state from Hubreview

Did you use our predecessor [Hubreview](https://github.com/joakimk/hubreview)?

Run this in a Heroku console in the Hubreview repo:

```
json = Revision.where(reviewed: true).pluck(:name, :in_review_at, :created_at, :review_time).map { |n,ra,ca,rt| { sha: n, at: ((ra || ca) + rt.to_i).to_i } }.to_json; nil
File.write("tmp/json", json)
`scp tmp/json you@your-server`
```

And this in Remit:

```
`scp you@your-server:json tmp/json`
raw = File.read("tmp/json"); raw.length
data = JSON.parse(raw); data.first
data.each { |x| Commit.where(sha: x["sha"]).where("reviewed_at IS NULL").update_all(reviewed_at: Time.at(x["at"])) }
```


## Use with Fluid.app

Remit is intended to be used side-by-side with a GitHub pane.

This is sadly not possible with regular frames or iframes, as GitHub doesn't allow embedding. But it can be achieved with [Fluid.app](http://fluidapp.com/).

Fluid.app is for OS X. Please do contribute instructions for other platforms.

* Install [Fluid.app](http://fluidapp.com/).
* Launch Fluid.app, create a new app:
  * The URL should be `http://github.com`.
  * Use any name and icon you like. It defaults to the GitHub icon.
  * Let it launch the app.
* Open your app's preferences and configure it like this:
  * Whitelist:
    * Allow browsing to any URL
  * Panel Preferences:
    * [X] New windows automatically display visible Panels from previous window
    * Panel split divider style: thin (a purely aesthetic choice; may need a restart of the app to kick in)
  * The first of the two "Browsa" panels:
    * Enter the Remit URL as home page, including the `auth_key` parameter. E.g. `https://remit-SOMETHING-UNIQUE.herokuapp.com/?auth_key=MY_AUTH_KEY`
    * Navigation bar: is always hidden
    * Clicked links open in: current tab in current window
* In the "Panels" menu, select the first Browsa panel to show it
* Drag the divider until it looks good

Remit will automatically remove the `target="_blank"` from links when Fluid.app is detected, so "current tab in current window" does the right thing.


## Credits

* Mostly by [Henrik Nyh](http://henrik.nyh.se)
* Very much inspired by [Hubreview](https://github.com/joakimk/hubreview) by [Joakim Kolsjö](https://github.com/joakimk)


## License

Copyright (c) 2014 Henrik Nyh

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
