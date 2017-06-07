module Models exposing(..)

import RemoteData exposing (WebData)

initialModel : Route -> Model
initialModel route =
  { route = route
  , genre = 
    { currentGenre = Nothing
    , genres = RemoteData.Loading 
    }
  , movie =
    { currentMovie = Nothing
    , movies = RemoteData.NotAsked
    }
  }

-- Model

type alias Model =  
  { route : Route
  , movie : MovieModel
  , genre : GenreModel
  }

type alias GenreModel = 
  { currentGenre : Maybe Genre
  , genres : WebData GenreFetchModel }

type alias MovieModel = 
  { currentMovie : Maybe Movie
  , movies : WebData MoviesFetchModel }

-- Routing

type Route
  = MoviesRoute
  | MovieGenreRoute String
  | MovieDetailRoute String String
  | NotFoundRoute

-- Resource types

type alias Movie = 
  { adult: Bool
  , backdrop_path: String
  , genre_ids: List Int
  , id: Int
  , original_language: String
  , original_title: String
  , overview: String
  , release_date: String
  , poster_path: String
  , popularity: Float
  , title: String
  , video: Bool
  , vote_average: Float
  , vote_count: Int }

type alias Genre =
  { id: Int
  , name: String }

-- Fetched types

type alias GenreFetchModel = 
  { genres: List Genre }

type alias MoviesFetchModel = 
  { id: Int
  , page: Int
  , results: List Movie
  , total_pages: Int
  , total_results: Int }