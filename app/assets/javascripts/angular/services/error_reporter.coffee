app.service "ErrorReporter", ($window) ->

  this.reportServerError = ->
    if $window.confirm("Server error! Your update may have been lost. Reload the page to make sure you're up to date.")
      $window.location.reload()

  this
