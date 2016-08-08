module Oorb exposing (..)

import Html            exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events     exposing (onInput)
import String          exposing (..)

type alias Letters  = List Letter

type alias Sections = List Sect

type alias Letter = (String, String)

type alias Sect   = (String, Combo )

type alias Combo  = List String

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
    |> String.split("")
    |> List.map (\x -> convertChar x jsonData)
    |> String.join ("")

convertChar : String -> JsonData -> String
convertChar l jsonData =
  if isIn l jsonData.sections then
    convertSect l jsonData
  else if isIn l jsonData.letters then
    convertLetter l jsonData
  else
    l

isIn : String -> List ( String, a) -> Bool
isIn l list =
  List.any (\x -> fst x == l) list


convertSect l jsonData =
  "SECTION"

convertLetter l jsonData =
  "LETTER"


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
