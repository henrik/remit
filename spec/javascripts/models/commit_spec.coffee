#= require helpers/spec_helper
#= require angular/models/commit

describe "Model: Commit", ->
  it "initializes with properties from the given object", ->
    commit = new Commit(foo: "bar")
    expect(commit.foo).toEqual("bar")

  describe "::decorate", ->
  it "decorates plain objects", ->
    commits = Commit.decorate [ { foo: "bar" }, { foo: "baz" } ]
    expect(commits[0] instanceof Commit).toBeTruthy()
    expect(commits[1] instanceof Commit).toBeTruthy()

  describe ".hasAuthor", ->
    it "is true if the authorName matches by substring", ->
      commit = new Commit(authorName: "Foo, Bar and Baz")
      expect(commit.hasAuthor("Bar")).toBeTruthy()

    it "is false if the authorName does not match by substring", ->
      commit = new Commit(authorName: "Foo, Bar and Baz")
      expect(commit.hasAuthor("Banana")).toBeFalsy()

    it "is false if no name was provided", ->
      commit = new Commit(authorName: "Foo, Bar and Baz")
      expect(commit.hasAuthor(null)).toBeFalsy()
