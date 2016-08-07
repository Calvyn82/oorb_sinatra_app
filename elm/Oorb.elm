module Oorb exposing (..)

import Html exposing (..)
import Html.App as App
import String exposing (..)

type alias Model =
  { content : String }

main =
  App.programWithFlags
    { init   = init
    , update = update
    , subscriptions = \_ -> Sub.none
    , view   = view
    }

init : Model -> (Model, Cmd msg)
init model =
    model ! []

view model =
  div [] [ text model.content ]

update : Cmd -> Model -> (Model, Cmd msg)
update message model = model ! []
