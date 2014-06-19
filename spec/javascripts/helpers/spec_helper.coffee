#= require angular
#= require angular-mocks
#= require helpers/fake_app

beforeEach module "Remit"

window.provide = (name, value) ->
  module ($provide) ->
    $provide.value name, value
    null
