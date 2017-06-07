module Sidebar.View exposing(..)

import Html exposing (Html, div, text, p, ul, li, a)
import Html.Attributes exposing(class, href)

import Messages exposing(..)

import Routing exposing (movieGenrePath)

import Models exposing (GenreModel, GenreFetchModel, Genre)
import RemoteData exposing (WebData)

sidebar : GenreModel -> Html Msg
sidebar genre =
  div [class "sidebar"]
    [ div [class "sidebar-heading"] [text "App"]
    , maybeMenu genre.genres]

maybeMenu : WebData GenreFetchModel -> Html Msg
maybeMenu response =
  case response of 
    RemoteData.NotAsked ->
      text ""
          
    RemoteData.Loading ->
      text "Loading..."

    RemoteData.Success genres->
      menu genres.genres

    RemoteData.Failure error ->
      text (toString error)

menu : List Genre -> Html Msg
menu genres = 
  div [class "menu"] 
    [ p [class "menu-label sidebar-label"] [ text "Categories" ]
    , ul [class "menu-list"] (List.map menuRow genres)
    ]

menuRow : Genre -> Html Msg
menuRow genre = 
  li [] [ a [href (movieGenrePath (String.toLower genre.name))] [text genre.name]]