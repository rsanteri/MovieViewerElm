
import './styles/bulma.min.css'
import './styles/main.css'
import './elm/elm-styles.css'

const Elm = require('./elm/App.elm')

const root = document.getElementById('root')

Elm.App.embed(root)
