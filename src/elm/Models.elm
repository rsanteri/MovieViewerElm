module Models exposing(..)

import RemoteData exposing (WebData)

initialModel : Route -> Model
initialModel route =
  { route = route
  , genre = 
    { currentGenre = ""
    , genres = RemoteData.Loading 
    }
  , movie = Nothing }

-- Model

type alias Model =  
  { route : Route
  , movie : Maybe Movie
  , genre : GenreModel
  }

type alias GenreModel = 
  { currentGenre : String
  , genres : WebData GenreFetchModel }
-- Routing

type Route
  = MoviesRoute
  | MovieGenreRoute String
  | MovieDetailRoute String String
  | NotFoundRoute

-- Resource types

type alias Movie = { name: String }

type alias Genre =
  { id: Int
  , name: String }

-- Fetched types

type alias GenreFetchModel = 
  { genres: List Genre }

