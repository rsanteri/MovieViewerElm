module Messages exposing (..)

import Navigation exposing (Location)

import Models exposing (Movie)

type Msg
    = OnLocationChange Location
    | SetActiveMovie Movie
    | ClearActiveMovie
    | NoOp