# Remit

**Very much a work in progress! Beware.**

Web app for commit-by-commit code review of GitHub repositories. A modern, live UI thanks to AngularJS and WebSockets.

Keeps track of what has been reviewed and links to GitHub commits for the actual review.

Also tracks comments on commits.

### Demo

Review the Remit commits using Remit:

<https://remit-on-remit.herokuapp.com/?auth_key=demo>

### Why commit-by-commit review?

If you think truly continuous integration and delivery (perhaps with feature flags) is important, you may prefer not to work with pull requests as a rule.

If you don't work with pull requests, commit-by-commit review is what you get. It has some benefits and some downtimes compared to review by pull request.

Read more in this blog post: ["The risks of feature branches and pre-merge code review"](http://thepugautomatic.com/2014/02/code-review/).

### The name

* <b>Re</b>view com<b>mit</b>s
* Dictionary meanings like
  * "an item referred to someone for consideration"
  * "forgive (a sin)"

## Setup

### Development

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

#### Fake new data coming in

    rake dev:commits N=3  # 3 new commits
    rake dev:comments N=3  # 3 new comments

### Test

    rake

### Production

#### Set the app up on Heroku

    heroku new remit-SOMETHING-UNIQUE

    # DB. Free plan with max 10,000 rows.
    heroku addons:add heroku-postgresql:dev

    # For WebSockets. Free plan with 20 concurrents, 100,000 messages/month. https://addons.heroku.com/pusher
    heroku addons:add pusher

    heroku config:set AUTH_KEY=`ruby -rsecurerandom -e "puts SecureRandom.urlsafe_base64"` WEBHOOK_KEY=`ruby -rsecurerandom -e "puts SecureRandom.urlsafe_base64"` SECRET_KEY_BASE=`rake secret`
    git push heroku master
    heroku run rake db:schema:load

#### Configure the webhook on GitHub

Working at [Barsoom](http://barsoom.se)? [We've got you covered.](https://github.com/barsoom/servers/wiki/Automatically-apply-webhooks-to-all-our-repos)

Not so fortunate? In the settings for any repo you want to use this with, add a webhook:

    Payload URL:   https://remit-SOMETHING-UNIQUE.herokuapp.com/github_webhook?auth_key=MY_WEBHOOK_KEY
    Content type:  application/json
    Let me select individual events:  [x] Push  [x] Commit comment

Where `MY_AUTH_KEY` is whatever you assigned above (see it again with `heroku config:get WEBHOOK_KEY`).


## Use with Fluid.app

With [Fluid.app](http://fluidapp.com/), you can see Remit side-by-side with GitHub in two panes.

This is not possible with regular iframes, as GitHub doesn't allow embedding.

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
    * Panel split divider style: thin (may need a restart of the app to kick in)
  * The first of the two "Browsa" panels:
    * Enter the Remit URL as home page, including the `?auth_key=SOMETHING` parameter, and tack on an `app=true` parameter.
    * Navigation bar: is always hidden
    * Clicked links open in: current tab in current window
* In the "Panels" menu, select the first Browsa panel to show it
* Drag the divider until it looks good

The `app=true` parameter tells Remit you want it to behave differently than in a regular browser.

## Credits

* Mostly by [Henrik Nyh](http://henrik.nyh.se)
* Very much inspired by [Hubreview](https://github.com/joakimk/hubreview) by [Joakim Kolsjö](https://github.com/joakimk)


## License

Copyright (c) 2014 Henrik Nyh

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
