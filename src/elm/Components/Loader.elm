module Components.Loader exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)

loader : Html msg
loader = 
  div [class "loader-container"]
    [ div [class "loader"] []]