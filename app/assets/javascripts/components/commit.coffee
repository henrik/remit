@Remit.Commit = React.createClass
  displayName: "Commit"

  render: ->
    commit = @props.commit

    className = "commit"
    className += " is-reviewed" if commit.isReviewed

    gravatar_hash = md5(commit.authorEmail)

    <li className={className}>
      <a className="block-link">
        <div className="commit-wrapper">
          <div className="commit-controls">
            <div>
              <button className="small start-review">
                <i className="fa fa-eye">Start review</i>
              </button>
            </div>
          </div>
          <img className="commit-avatar" src="https://secure.gravatar.com/avatar/#{gravatar_hash}?size=40&amp;rating=x&amp;default=mm"></img>
          <div className="commit-summary-and-details">
            <div className="commit-summary">{commit.summary}</div>
            <div className="commit-details">
              {" in "}
              <strong>{commit.repository}</strong>
              <span className="by-author">
                {" by "}
                <strong>{commit.authorName}</strong>
                {" on "}
                <span>{commit.timestamp}</span>
              </span>
            </div>
          </div>
        </div>
      </a>
    </li>
