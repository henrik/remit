#= require angular
#= require angular-mocks

beforeEach module "Remit"

window.provide = (name, value) ->
  module ($provide) ->
    $provide.value name, value
    null
