module Util.Helper exposing (..)

import Models exposing (Genre, GenreFetchModel)

import RemoteData exposing (WebData)
import Regex exposing(HowMany(All), regex, replace)

toUrlString : String -> String
toUrlString string = 
  replace All (regex "[ '.,^:]") (\_ -> "_") string
    |> String.toLower

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