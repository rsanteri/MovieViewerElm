module Sidebar.View exposing(..)

import Html exposing (Html, div, text, p, ul, li, a)
import Html.Attributes exposing(class, href)

import Messages exposing(..)

import Routing exposing (movieGenrePath)

import Models exposing (GenreModel, GenreFetchModel, Genre)
import RemoteData exposing (WebData)

import Util.Helper exposing (toUrlString)

sidebar : GenreModel -> Html Msg
sidebar genre =
  div [class "sidebar"]
    [ div [class "sidebar-heading"] [text "App"]
    , userMenu
    , maybeMenu genre.genres]

-- MENU

-- Handle different stages of response
maybeMenu : WebData GenreFetchModel -> Html Msg
maybeMenu response =
  case response of 
    RemoteData.NotAsked ->
      text ""
          
    RemoteData.Loading ->
      text "Loading..."

    RemoteData.Success genres ->
      menu genres.genres

    RemoteData.Failure error ->
      text (toString error)

userMenu : Html Msg
userMenu =
  div [class"menu"]
    [ p [class "menu-label sidebar-label"] [text "User"]
    , ul [class "menu-list"]
      [ li [] [ a [href "#/watch"] [text "Watch"]]
      , li [] [ a [href "#/favourites"] [text "Starred"]]
      ]
    ]

menu : List Genre -> Html Msg
menu genres = 
  div [class "menu"] 
    [ p [class "menu-label sidebar-label"] [ text "Categories" ]
    , ul [class "menu-list"] (List.map menuRow genres)
    ]

menuRow : Genre -> Html Msg
menuRow genre = 
  li [] [ a [href (movieGenrePath (toUrlString genre.name))] [text genre.name]]