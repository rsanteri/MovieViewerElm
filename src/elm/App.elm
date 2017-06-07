module App exposing (..)

import Html exposing (Html, text, div, img)
import Html.Attributes exposing (class)

import Messages exposing(Msg(OnLocationChange))
import Navigation exposing (Location)
import Routing exposing (..)
import Update exposing (update)

import Sidebar.View exposing (sidebar)
import Content.View exposing (content)
import Movies.MovieDetail exposing (moviedetail)

import Models exposing(initialModel, Model, Movie, Route(MovieDetailRoute, MovieGenreRoute))

import Commands exposing (fetchGenres)

import Messages exposing(..)
---- MODEL ----

init : Location -> ( Model, Cmd Msg )
init location =
  let
    currentRoute =
      Routing.parseLocation location
  in
  ( initialModel currentRoute, fetchGenres )

---- VIEW ----


view : Model -> Html Msg
view model =
    div [class "view"]
        [ sidebar model.genre
        , content model
        , moviedetail model
        ]

---- PROGRAM ----

main : Program Never Model Msg
main =
  Navigation.program OnLocationChange
    { view = view
    , init = init
    , update = update
    , subscriptions = \_ -> Sub.none
    }