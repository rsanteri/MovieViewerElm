module Movies.MovieDetail exposing (moviedetail)

import Html exposing (Html, div, text, h1, p, img, a)
import Html.Attributes exposing (class, src, href)

import Messages exposing (Msg(ClearActiveMovie))
import Models exposing (Model)
import Routing exposing (movieGenrePath)

moviedetail : Model -> Html Msg 
moviedetail model =
  case model.movie of
    Nothing -> div [] []
    _ ->
      div [class "movie-detail-overlay"]
        [ div [class "movie-detail"] 
          [ div [class "movie-detail-media-section"] 
            [ img [src "https://i.jeded.com/i/the-good-the-bad-and-the-ugly-il-buono-il-brutto-il-cattivo.154-9123.jpg"] [] ]

          , div [class "movie-detail-information"]
            [ a [class "movie-detail-close delete", href (movieGenrePath model.genre.currentGenre)] []
            , h1 [class "movie-title"] [text "The Good the bad and the ugly"]
            , p [] [text "Palasin juuri uudesta koulustani, sain tänään tietää, että minun ei tarvitse osallistua ollenkaan ruotsin kielen tunneille, sillä kielitaitoni on niin vahva! Jee, tosi hienoa, saan skipattua kuulemma koko kurssin! Asuin vuonna -98 Ruotsissa ja opiskelin ruotsin kieltä Uppsalan yliopistossa, joten minun ei tarvitse käydä perusasioita enää läpi. "]
            ]
          ]
        ]

