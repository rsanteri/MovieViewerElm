module Update exposing(update)

import Models exposing (..)
import Messages exposing (..)

import Routing exposing (..)

---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    SetActiveMovie movie ->
      ({model | movie = Just movie}, Cmd.none)
    ClearActiveMovie ->
      ({model | movie = Nothing}, Cmd.none)
    OnLocationChange location ->
      let
        newRoute =
          parseLocation location
      in
        case newRoute of
          MovieDetailRoute genre name ->
            ( { model 
              | route = newRoute
              , movie = Just (Movie name)}, Cmd.none )
          
          MovieGenreRoute genre ->
            ( { model 
                | route = newRoute
                , genre = genre
                , movie = Nothing}, Cmd.none )

          _ -> 
            ( { model | route = newRoute }, Cmd.none )

    _ ->
      (model, Cmd.none)