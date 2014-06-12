# Remit

**Very much a work in progress! Beware.**

A tool for commit-by-commit code review of repositories on GitHub.

More or less a rewrite of [Hubreview](https://github.com/joakimk/hubreview) to try some new things starting from a fresh slate.

## The brilliance of the name

* **Re**view com**mit**s
* Dictionary meanings like
  * "an item referred to someone for consideration"
  * "refer (a matter for decision) to an authority"
  * "send (someone) from one tribunal to another for a trial or hearing"
  * "forgive (a sin)"

## Idea dump

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
* MAYBE: stats on how much you review. But avoid it becoming a competition.
