app.filter "trustBoundHtml", ($sce) ->
  (val) ->
    $sce.trustAsHtml(val)
