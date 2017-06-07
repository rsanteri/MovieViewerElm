module Update exposing(update)

import Models exposing (..)
import Messages exposing (..)

import Routing exposing (..)
import Commands exposing (fetchMovies)

import RemoteData exposing (WebData)

---- UPDATE ----

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    SetActiveMovie movie ->
      ({model | movie = setCurrentMovie model.movie (Just movie)}, Cmd.none)
    ClearActiveMovie ->
      ({model | movie = setCurrentMovie model.movie Nothing}, Cmd.none)

    -- FETCHING

    OnFetchGenres response ->
      let
        oldGenre = model.genre
        newGenre = {oldGenre | genres = response}
      in
        ( {model | genre = newGenre }, Cmd.none )

    OnFetchMovies response ->
      let
        oldMovie = model.movie
        newMovie = {oldMovie | movies = response}
      in
        ( {model | movie = newMovie }, Cmd.none )

    -- ROUTING

    OnLocationChange location ->
      let
        newRoute =
          parseLocation location
      in
        case newRoute of
          MovieDetailRoute genre name ->
            ( { model 
              | route = newRoute
              , movie = setCurrentMovie model.movie Nothing}, Cmd.none )
          
          MovieGenreRoute genre ->
            let
              oldGenre = model.genre
              newGenre = {oldGenre | currentGenre = findGenre model.genre.genres genre}
            in
              ( { model 
                  | route = newRoute
                  , genre = newGenre
                  , movie = setCurrentMovie model.movie Nothing}, fetchMovies (genreId newGenre.currentGenre) )

          _ -> 
            ( { model | route = newRoute }, Cmd.none )

    _ ->
      (model, Cmd.none)


findGenre : WebData GenreFetchModel -> String -> Maybe Genre
findGenre genres name =
  case genres of
    RemoteData.Success genres -> 
      List.head (List.filter (\g -> (String.toLower g.name) == name) genres.genres)
    _ -> Nothing

genreId : Maybe Genre -> Int
genreId genre = 
  case genre of
    Just genre -> genre.id 
    _ -> 37

setCurrentMovie : MovieModel -> Maybe Movie -> MovieModel
setCurrentMovie movieModel maybeMovie = { movieModel | currentMovie = maybeMovie }