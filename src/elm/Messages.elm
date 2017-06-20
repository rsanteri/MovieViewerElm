module Messages exposing (..)

import Navigation exposing (Location)

import Models exposing (Movie, GenreFetchModel, MoviesFetchModel)
import RemoteData exposing (WebData)
import Animation exposing (..)

type Msg
    = OnLocationChange Location
    | SetActiveMovie Movie
    | ClearActiveMovie

    | OnFetchGenres (WebData GenreFetchModel)

    | OnFetchMoviesStart Int
    | OnFetchMovies (WebData MoviesFetchModel)

    | Animate Animation.Msg

    | NoOp
