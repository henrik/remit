#= require helpers/spec_helper
#= require angular/models/commit

describe "Model: Commit", ->
  it "initializes with properties from the given object", ->
    commit = new Commit(foo: "bar")
    expect(commit.foo).toEqual("bar")

  describe "Commit.decorate", ->
  it "decorates plain objects", ->
    commits = Commit.decorate [ { foo: "bar" }, { foo: "baz" } ]
    expect(commits[0] instanceof Commit).toBeTruthy()
    expect(commits[1] instanceof Commit).toBeTruthy()
