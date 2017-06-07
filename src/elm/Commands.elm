module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Messages exposing (Msg(OnFetchGenres))
import Models exposing (Genre, GenreFetchModel)
import RemoteData

import Config exposing (apikey)

fetchGenres : Cmd Msg 
fetchGenres = 
  Http.get fetchGenresUrl genresDecoder
    |> RemoteData.sendRequest
    |> Cmd.map OnFetchGenres

fetchGenresUrl : String
fetchGenresUrl = 
  "https://api.themoviedb.org/3/genre/movie/list?api_key=" ++ apikey ++ "&language=en-US"

genresDecoder : Decode.Decoder GenreFetchModel
genresDecoder = 
  decode
    GenreFetchModel
    |> required "genres" (Decode.list genreDecoder)

genreDecoder : Decode.Decoder Genre
genreDecoder = 
  decode Genre
    |> required "id" Decode.int 
    |> required "name" Decode.string