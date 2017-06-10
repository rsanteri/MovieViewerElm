module Util.Helper exposing (..)

import Regex exposing(HowMany(All), regex, replace)

toUrlString : String -> String
toUrlString string = 
  replace All (regex "[ '.,^:]") (\_ -> "_") string
    |> String.toLower