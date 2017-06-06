module Sidebar.View exposing(..)

import Html exposing (Html, div, text, p, ul, li, a)
import Html.Attributes exposing(class, href)

import Messages exposing(..)

import Routing exposing (movieGenrePath)

sidebar : Html Msg
sidebar =
  div [class "sidebar"]
    [ div [class "sidebar-heading"] [text "App"]
    , menu]


menu : Html Msg
menu = 
  div [class "menu"] 
    [ p [class "menu-label sidebar-label"] [ text "Categories" ]
    , ul [class "menu-list"]
      [ li [] [ a [href "/#/"] [text "All"]]
      , li [] [ a [href (movieGenrePath "drama")] [text "Drama"]]
      , li [] [ a [href (movieGenrePath "western")] [text "Western"]]
      , li [] [ a [href (movieGenrePath "scifi")] [text "Scifi"]]
      ]
    ]