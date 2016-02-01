module Remit where

import Html exposing (..)
import Html.Attributes exposing (..)

port maxRecords : Int
port commits : List Commit

type alias Commit =
  { id : Int
  , authorName : String
  , authorEmail : String
  , summary : String
  , url : String
  , repository : String
  , timestamp : String
  , receivedTimestamp : String
  , isNew : Bool
  , isBeingReviewed : Bool
  , isReviewed : Bool
  , pendingReviewerEmail : Maybe String
  , reviewerEmail : Maybe String
  }

main =
  div [ class "wrapper" ] [
    div [ class "top-nav" ] [ ]
  , renderCommitList
  ]

renderCommitList =
  ul [ class "commits-list" ] (List.map renderCommit commits)

renderCommit commit =
  li [] [
    a [ class "block-link" ] [
      div [ class "commit-wrapper" ] [
        div [ class "commit-controls" ] []
      , img [ class "commit-avatar", src "" ] []
      , div [ class "commit-summary-and-details" ] [
          div [ class "commit-summary" ] [ text commit.summary ]
        ]
      ]
    ]
  ]
