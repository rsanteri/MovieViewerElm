module Movies.MovieDetail exposing (moviedetail)

import Html exposing (Html, div, text, h1, p, span, img)
import Html.Attributes exposing (class, src, href)
import Html.Events exposing (onClick)

import Messages exposing (Msg(ClearActiveMovie, ClearActiveMovie))
import Models exposing (Model, Genre, GenreFetchModel)

import RemoteData exposing (WebData)

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
            , span [class "tag is-primary is-medium info-tag"] [ text (toString(movie.vote_average) ++ " / " ++ toString(movie.vote_count)) ]
            , span [class "tag is-primary is-medium info-tag"] [text (String.join ", " (findGenreNames model.genre.genres movie.genre_ids))]
            ]
          ]
        ]

findGenreNames : WebData GenreFetchModel -> List Int -> List String
findGenreNames genres ids =
  case genres of
    RemoteData.Success fetched -> 
      let
        filtered = List.filter (oneOfIds ids) fetched.genres
      in
        case List.length filtered of
          0 -> []
          _ -> List.map (\g -> g.name) filtered
        
    _ -> []

oneOfIds : List Int -> Genre -> Bool
oneOfIds genreIds genre =
  let 
    ids = List.filter (\id -> id == genre.id) genreIds
  in
    List.length ids > 0
        