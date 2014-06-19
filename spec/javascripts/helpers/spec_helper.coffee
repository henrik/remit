#= require angular
#= require angular-mocks

window.provide = (name, value) ->
  module ($provide) ->
    $provide.value name, value
    null
