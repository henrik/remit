@Remit.CommitList = React.createClass
  displayName: "CommitList"

  render: ->
    <ul className="commits-list">
      {<Remit.Commit commit={commit} key={commit.id} /> for commit in @props.commits}
    </ul>
