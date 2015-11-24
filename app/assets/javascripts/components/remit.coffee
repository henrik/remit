@Remit = React.createClass
  displayName: "Remit"

  render: ->
    <div className="wrapper">
      <div className="top-nav">
      </div>

      <Remit.CommitList commits={@props.commits} />
    </div>
