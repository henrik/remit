class @ApplicationModel
  @decorate: (data) ->
    klass = @
    data.map (datum) -> new klass(datum)

  constructor: (props) ->
    this[name] = value for name, value of props

  hasAuthor: (authorName) ->
    authorName and @authorName.indexOf(authorName) != -1
