module Movies.MovieList exposing (..)

import Html exposing (Html, div, text, img, p, a)
import Html.Attributes exposing (class, src, href)
import Html.Events exposing (onClick)

import Messages exposing(Msg(SetActiveMovie))
import Models exposing (MovieModel, Movie, GenreModel, Genre)

import RemoteData exposing (WebData)

movielist : MovieModel -> GenreModel -> Html Msg
movielist movieModel genreModel = 
  case movieModel.movies of
    RemoteData.NotAsked ->
      text "Not asked"
    
    RemoteData.Loading ->
      text "Loading"

    RemoteData.Success m ->
      div [class "movie-list"] 
        (List.map (movie genreModel.currentGenre) m.results)

    RemoteData.Failure error ->
      text (toString error)

movie : Maybe Genre -> Movie -> Html Msg 
movie genre movie =
  case genre of
    Nothing -> div [] []
    Just genre ->
      div [class "movie-card card", onClick (SetActiveMovie movie)]
        [ div [class "card-image"]
            [ div [class "image"] 
              [ img [src ("https://image.tmdb.org/t/p/w300" ++ movie.poster_path)] []] ]
        
        , div [class "movie-card-content card-content"]
            [ p [class "movie-title"] [text movie.title]
            , p [class "movie-genre"] [text "western|classic"]]
        ]