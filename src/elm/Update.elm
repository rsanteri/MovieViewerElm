module Update exposing(update)

import Models exposing (..)
import Messages exposing (..)

import Routing exposing (..)
import Commands exposing (fetchMovies)

import RemoteData exposing (WebData)

import Util.Helper exposing (toUrlString)

import Animation exposing(update)
import Components.Loader exposing(hideLoader, showLoader)

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
      ( {model | genre = setGenres model.genre response }, Cmd.none )

    OnFetchMovies response ->
      ( { model | movie = setMovies model.movie response
        , loaderStyle = hideLoader model.loaderStyle }, Cmd.none )

    Animate animMsg ->
          ( { model
              | loaderStyle = Animation.update animMsg model.loaderStyle
            }
          , Cmd.none
          )

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
              , movie = setCurrentMovie model.movie (findMovie model.movie.movies name)
              , loaderStyle = showLoader model.loaderStyle }, Cmd.none )
          
          MovieGenreRoute genre ->
            let
              oldGenre = model.genre
              foundGenre = findGenre model.genre.genres genre
              newGenre = {oldGenre | currentGenre = foundGenre}
            in
              ( { model 
                  | route = newRoute
                  , genre = newGenre
                  , movie = { currentMovie = Nothing, movies = RemoteData.Loading }
                  , loaderStyle = showLoader model.loaderStyle}, fetchMovies (genreId foundGenre))

          _ -> 
            ( { model | route = newRoute }, Cmd.none )

    _ ->
      (model, Cmd.none)


findGenre : WebData GenreFetchModel -> String -> Maybe Genre
findGenre genres name =
  case genres of
    RemoteData.Success genres -> 
      List.filter (\g -> (toUrlString g.name) == name) genres.genres
        |> List.head
        
    _ -> Nothing


genreId : Maybe Genre -> Int
genreId genre = 
  case genre of
    Just genre -> genre.id
    -- Western by default
    _ -> 37


findMovie : WebData MoviesFetchModel -> String -> Maybe Movie
findMovie movies name =
  case movies of
    RemoteData.Success movies -> 
      List.filter (\m -> (toUrlString m.title) == name) movies.results
        |> List.head

    _ -> Nothing


setMovies : MovieModel -> WebData MoviesFetchModel -> MovieModel
setMovies movieModel movies = { movieModel | movies = movies }

setCurrentMovie : MovieModel -> Maybe Movie -> MovieModel
setCurrentMovie movieModel maybeMovie = { movieModel | currentMovie = maybeMovie }

setGenres : GenreModel -> WebData GenreFetchModel -> GenreModel
setGenres genreModel genres = { genreModel | genres = genres }