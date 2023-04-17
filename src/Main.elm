module Main exposing ( main )

import Browser
import Browser.Navigation as Nav
import Html exposing ( .. )
import Html.Attributes exposing ( .. )
import Url exposing ( Url )
import Url.Parser as P
import Url.Parser.Query as Q

import Components exposing ( .. )
import Difficulty exposing ( defaultDifficulty )
import Types exposing ( .. )

main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        , onUrlRequest = UrlRequest
        , onUrlChange = UrlChange
        }

getDiffParam : Url -> Maybe String
getDiffParam url =
  let diffParamParser = P.query (Q.string "d")
  in
  case P.parse diffParamParser url of
      Just x -> x
      Nothing -> Nothing

getPath : Url -> String
getPath url =
  let pathParser = P.string
  in
  case P.parse pathParser url of
      Just x -> x
      Nothing -> "/"

init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url _ =
    let
      diff = case getDiffParam url of
              Just name -> Difficulty.fromString name
              Nothing -> Just defaultDifficulty
      path = getPath url
      test = case getDiffParam url of
               Just x -> x
               Nothing -> "?"
    in
    Debug.log test
    ( Model diff path, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    UrlChange _ -> ( model, Cmd.none )
    UrlRequest request ->
      case request of
        Browser.Internal url ->
          ( model
          , Nav.load (Url.toString url)
          )
        Browser.External url ->
          ( model
          , Nav.load url
          )
          

view : Model -> Browser.Document Msg
view model =
    Browser.Document "Minesweeper" (
      case model.difficulty of
        Just diff ->
          [ div []
              [ p [] [ text ("Current difficulty is " ++ diff.displayName) ]
              , br [] []
              , difficultySelector model
              , br [] []
              , aboutPage
              ]
          ]
        Nothing ->
          [ h1 [] [ text "Unknown Difficulty." ]
          , difficultySelector model
          , br [] []
          , aboutPage
          ]
    )
