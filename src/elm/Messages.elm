module Messages exposing (..)

import Navigation exposing (Location)

import Models exposing (Movie, GenreFetchModel)
import RemoteData exposing (WebData)

type Msg
    = OnLocationChange Location
    | SetActiveMovie Movie
    | ClearActiveMovie

    | OnFetchGenres (WebData GenreFetchModel)

    | NoOp
