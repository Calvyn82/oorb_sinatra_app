module Oorb exposing (..)

import Html            exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events     exposing (onInput)
import String          exposing (..)
import Dict            exposing (..)

type alias Letters  = List String

type alias Sections = List String

type alias JsonData =
  { letters  : Letters
  , sections : Sections
  }

type alias Model =
  { jsonData        : JsonData
  , textBoxContents : String
  , output          : String
  }

type Msg =
  Change String

update : Msg -> Model -> ( Model, Cmd Msg)
update msg model =
  case msg of
    Change newTextBoxContents ->
      ({ model | output = buildRegex newTextBoxContents model.jsonData }, Cmd.none)

buildRegex : String -> JsonData -> String
buildRegex boxContents jsonData =
  boxContents
    |> toLower
    |> String.toList
    |> List.map (\x -> convertLetter x jsonData)
    |> String.join ("")

convertLetter : Char -> JsonData -> String
convertLetter l jsonData =
  String.fromChar l

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
    , div [] [ text (  model.output ) ]
    ]
