module Oorb exposing (..)

import Html            exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events     exposing (onInput)
import String          exposing (..)
import Dict            exposing (..)
import Regex           exposing (..)

type alias Letters  = List Letter

type alias Sections = List Sect

type alias Letter = (String, String)

type alias Sect   = (String, String)

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
    |> String.toLower
    |> String.split("")
    |> List.map (\x -> convertUnit x jsonData )
    |> String.join("")

convertUnit : String -> JsonData -> String
convertUnit unit jsonData =
  let lettersDict =
        Dict.fromList jsonData.letters

      sectionsDict = buildSectionsDict jsonData
  in
      if Dict.get unit lettersDict |> Maybe.withDefault "nope" |> (/=) "nope" then
        "[" ++ (Dict.get unit lettersDict |> Maybe.withDefault "") ++ "]"

      else if Dict.get unit sectionsDict |> Maybe.withDefault "nope" |> (/=) "nope" then
        "[" ++ (Dict.get unit sectionsDict |> Maybe.withDefault "") ++ "]?"

      else if unit == " " then
        "\x5cs?"

      else
        escape unit


buildSectionsDict : JsonData -> Dict String String
buildSectionsDict jsonData =
  let
      sectionsKeys = Dict.fromList jsonData.sections
        |> Dict.keys

      outputDict = Dict.fromList jsonData.sections
  in
      List.foldl ( \x y ->
        Dict.insert x (formatValue (Dict.get x outputDict)) y
        ) outputDict sectionsKeys

formatValue value =
  value
    |> Maybe.withDefault ""
    |> String.split(" ")
    |> String.join("][")

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
  div [class "center"]
    [ input [ placeholder "Input Text", onInput Change ] []
    , button [class "oorb-btn", attribute "data-clipboard-target" "#copy-to-me"] [text "Copy Regex"]
    , div [id "copy-to-me"] [ text (  model.output ) ]
    ]
