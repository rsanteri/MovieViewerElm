module Movies.MovieDetail exposing (moviedetail)

import Html exposing (Html, div, text, h1, p, img)
import Html.Attributes exposing (class, src, href)
import Html.Events exposing (onClick)

import Messages exposing (Msg(ClearActiveMovie, ClearActiveMovie))
import Models exposing (Model, Genre)

moviedetail : Model -> Html Msg 
moviedetail model =
  case model.movie.currentMovie of
    Nothing -> div [] []
    Just movie ->
      div [class "movie-detail-overlay"]
        [ div [class "movie-detail"] 
          [ div [class "movie-detail-media-section"] 
            [ img [src ("https://image.tmdb.org/t/p/w300" ++ movie.poster_path)] [] ]

          , div [class "movie-detail-information"]
            [ div [class "movie-detail-close delete", onClick ClearActiveMovie] []
            , h1 [class "movie-title"] [text movie.title]
            , p [] [text movie.overview]
            ]
          ]
        ]