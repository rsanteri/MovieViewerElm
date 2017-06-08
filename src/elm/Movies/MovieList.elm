module Movies.MovieList exposing (..)

import Html exposing (Html, div, text, img, p, a)
import Html.Attributes exposing (class, src, href)

import Messages exposing(Msg(SetActiveMovie))
import Routing exposing (movieGenreDetailPath)
import Models exposing (MovieModel, Movie, Genre)

import RemoteData exposing (WebData)


movielist : MovieModel -> Maybe Genre -> Html Msg
movielist movies genre = 
  case movies.movies of
    RemoteData.NotAsked ->
      text "Not asked"
    
    RemoteData.Loading ->
      text "Fetching movies..."

    RemoteData.Success m ->
      div [class "movie-list"] 
        (List.map (movie genre) m.results)

    RemoteData.Failure error ->
      text (toString error)

movie : Maybe Genre -> Movie -> Html Msg 
movie genre movie =
  case genre of
    Nothing -> div [] []
    Just genre ->
      a [class "movie-card card", href (movieGenreDetailPath genre.name movie.title)]
        [ div [class "card-image"]
            [ div [class "image"] 
              [ img [src ("https://image.tmdb.org/t/p/w300" ++ movie.poster_path)] []] ]
        
        , div [class "movie-card-content card-content"]
            [ p [class "movie-title"] [text movie.title]
            , p [class "movie-genre"] [text "western|classic"]
            , p [class "movie-actors"] [text movie.overview]]
        ]