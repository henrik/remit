# Using the fully qualified names to get fewer "WARNING: Tried to load angular more than once."
#= require angular/angular
#= require angular-mocks/angular-mocks

window.provide = (name, value) ->
  module ($provide) ->
    $provide.value name, value
    null
