module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)
import Messages exposing (Msg(OnFetchGenres, OnFetchMovies))
import Models exposing (Genre, GenreFetchModel, Movie, MoviesFetchModel)
import RemoteData

import Config exposing (apikey)

-- GENRES

-- Fetch genres fro movie db api. https://developers.themoviedb.org/3/genres/get-movie-list
fetchGenres : Cmd Msg 
fetchGenres = 
  Http.get fetchGenresUrl genresDecoder
    |> RemoteData.sendRequest
    |> Cmd.map OnFetchGenres

-- Url must include api key
fetchGenresUrl : String
fetchGenresUrl = 
  "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=" ++ apikey

-- Decode response
genresDecoder : Decode.Decoder GenreFetchModel
genresDecoder = 
  decode
    GenreFetchModel
    |> required "genres" (Decode.list genreDecoder)

-- Decode single genre
genreDecoder : Decode.Decoder Genre
genreDecoder = 
  decode 
    Genre
    |> required "id" Decode.int 
    |> required "name" Decode.string


-- MOVIES

fetchMovies : Int -> Cmd Msg
fetchMovies genreId =
  Http.get (fetchMoviesUrl genreId) moviesDecoder
    |> RemoteData.sendRequest
    |> Cmd.map OnFetchMovies

fetchMoviesUrl : Int -> String
fetchMoviesUrl genreId = 
  "https://api.themoviedb.org/3/genre/" ++ toString genreId ++ "/movies?language=en-US&include_adult=false&sort_by=created_at.asc&api_key=" ++ apikey

moviesDecoder : Decode.Decoder MoviesFetchModel
moviesDecoder = 
  decode
    MoviesFetchModel
    |> required "id" Decode.int
    |> required "page" Decode.int
    |> required "results" (Decode.list movieDecoder)
    |> required "total_pages" Decode.int
    |> required "total_results" Decode.int

movieDecoder : Decode.Decoder Movie 
movieDecoder = 
  decode
    Movie
    |> required "adult" Decode.bool
    |> optional "backdrop_path" Decode.string ""
    |> required "genre_ids" (Decode.list Decode.int)
    |> required "id" Decode.int
    |> required "original_language" Decode.string
    |> required "original_title" Decode.string
    |> optional "overview" Decode.string ""
    |> required "release_date" Decode.string
    |> optional "poster_path" Decode.string ""
    |> required "popularity" Decode.float
    |> required "title" Decode.string
    |> required "video" Decode.bool
    |> required "vote_average" Decode.float
    |> required "vote_count" Decode.int 