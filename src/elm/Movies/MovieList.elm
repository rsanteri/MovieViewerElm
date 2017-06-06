module Movies.MovieList exposing (..)

import Html exposing (Html, div, text, img, p, a)
import Html.Attributes exposing (class, src, href)

import Messages exposing(Msg(SetActiveMovie))
import Routing exposing (movieGenreDetailPath)

movielist : String -> Html Msg
movielist genre = 
  div [class "movie-list"] 
    [ movie genre
    , movie genre
    , movie genre
    , movie genre ]

movie : String -> Html Msg 
movie genre = 
  a [class "movie-card card", href (movieGenreDetailPath genre "the-good-the-bad-the-ugly")]
    [ div [class "card-image"]
        [ div [class "image"] 
          [ img [src "https://i.jeded.com/i/the-good-the-bad-and-the-ugly-il-buono-il-brutto-il-cattivo.154-9123.jpg"] []] ]
    
    , div [class "movie-card-content card-content"]
        [ p [class "movie-title"] [text "The good, the bad and the ugly"]
        , p [class "movie-genre"] [text "western|classic"]
        , p [class "movie-actors"] [text "Clint Eastwood, Eli, Wallach, Lee Van Cleef"]]
    ]