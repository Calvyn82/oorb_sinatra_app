module Oorb exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String exposing (..)

type alias Model =
  { content : String
  }

model : Model
model =
  { content = "" }

type Msg =
  Change String

update : Msg -> Model -> ( Model, Cmd a)
update msg model =
  case msg of
    Change newContent ->
      ({ model | content = newContent ++ model.content }, Cmd.none)


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

view : Model -> Html Msg
view model =
  div []
    [ input [ placeholder "Input Text", onInput Change ] []
    , div [] [ text (  model.content ) ]
    ]
