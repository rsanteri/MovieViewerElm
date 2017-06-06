module Models exposing(..)

initialModel : Route -> Model
initialModel route =
  { route = route
  , genre = ""
  , movie = Nothing }

type alias Model =  
  { route : Route
  , genre : String
  , movie : Maybe Movie }

type alias Movie = { name: String }

type Route
  = MoviesRoute
  | MovieGenreRoute String
  | MovieDetailRoute String String
  | NotFoundRoute
