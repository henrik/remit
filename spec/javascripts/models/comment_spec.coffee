#= require helpers/spec_helper
#= require angular/models/comment

describe "Model: Comment", ->
  it "initializes with properties from the given object", ->
    comment = new Comment(foo: "bar")
    expect(comment.foo).toEqual("bar")

  describe "::decorate", ->
  it "decorates plain objects", ->
    comments = Comment.decorate [ { foo: "bar" }, { foo: "baz" } ]
    expect(comments[0] instanceof Comment).toBeTruthy()
    expect(comments[1] instanceof Comment).toBeTruthy()

  describe ".hasAuthor", ->
    it "is true if the authorName matches by substring", ->
      comment = new Comment(authorName: "Foo, Bar and Baz")
      expect(comment.hasAuthor("Bar")).toBeTruthy()

    it "is false if the authorName does not match by substring", ->
      comment = new Comment(authorName: "Foo, Bar and Baz")
      expect(comment.hasAuthor("Banana")).toBeFalsy()

    it "is false if no name was provided", ->
      comment = new Comment(authorName: "Foo, Bar and Baz")
      expect(comment.hasAuthor(null)).toBeFalsy()
