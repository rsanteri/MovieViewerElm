module Components.Loader exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Animation exposing(..)

loader : Animation.State -> Html msg
loader style = 
  div (Animation.render style ++ [ class "loader-container" ])
    [ div [class "loader"] []]


showLoader =
  Animation.interrupt
    [ Animation.set
        [ Animation.display Animation.flex ]
    
    , Animation.set
        [ Animation.opacity 1 ]
    ]

hideLoader =
  Animation.interrupt
    [ Animation.to
        [ Animation.opacity 0 ]
        
    , Animation.set
        [ Animation.display Animation.none ]
    ]
  