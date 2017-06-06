module Content.View exposing (..)

import Html exposing(Html, div, text )
import Html.Attributes exposing(class)

import Messages exposing (Msg)
import Models exposing(Model)

import Movies.MovieList exposing (movielist)

content : Model -> Html Msg
content model = 
  div [class "content"] 
    [ div [class "content-container"] [movielist model.genre] ]