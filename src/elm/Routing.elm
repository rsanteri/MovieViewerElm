module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing(Route(..))
import UrlParser exposing(..)

-- List all possible url paths to oneOf.
matchers : Parser (Route -> a) a 
matchers =
  oneOf
      [ map MoviesRoute top
      , map MovieGenreRoute (s "movies" </> string)
      , map MovieDetailRoute (s "movies" </> string </> string)
      , map MoviesRoute (s "movies") ]

-- Parse current location with matcher. If no match to our routes, return NotFoundRoute.
parseLocation : Location -> Route 
parseLocation location = 
  case (parseHash matchers location) of
    Just route ->
      route

    Nothing ->
      NotFoundRoute


-- Paths
movieGenrePath : String -> String
movieGenrePath genre = "#/movies/" ++ genre

movieGenreDetailPath : String -> String -> String
movieGenreDetailPath genre movieId = "#/movies/" ++ genre ++ "/" ++ movieId