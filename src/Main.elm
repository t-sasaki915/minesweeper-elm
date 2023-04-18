port module Main exposing ( main )

import Browser
import Browser.Navigation as Nav
import Html exposing ( .. )
import Html.Attributes exposing ( .. )
import Url exposing ( Url )

import Components exposing ( .. )
import Difficulty exposing ( defaultDifficulty )
import Types exposing ( .. )

main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequest
        , onUrlChange = UrlChange
        }

port receiveData : (String -> msg) -> Sub msg

init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ _ _ =
  ( Model Nothing "/" False False, Cmd.none )

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
    ReceiveDataFromJS data ->
      if String.startsWith "diff=" data then
        case String.dropLeft 5 data of
          "" ->
            ( { model | difficulty = Just defaultDifficulty, difficultyReceived = True }
            , Cmd.none
            )
          other ->
            ( { model | difficulty = Difficulty.fromString other, difficultyReceived = True }
            , Cmd.none
            )
      else if String.startsWith "path=" data then
        ( { model | path = String.dropLeft 5 data, pathReceived = True }
        , Cmd.none
        )
      else
        ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
  if model.difficultyReceived && model.pathReceived then
    Sub.none
  else
    receiveData ReceiveDataFromJS

view : Model -> Browser.Document Msg
view model =
    Browser.Document "Minesweeper" (
      if model.difficultyReceived && model.pathReceived then
        case model.difficulty of
          Just diff ->
            [ p [] [ text ("Current difficulty is " ++ diff.displayName) ]
            , br [] []
            , difficultySelector model
            , br [] []
            , aboutPage
            ]
          Nothing ->
            [ h1 [] [ text "Unknown Difficulty." ]
            , difficultySelector model
            , br [] []
            , aboutPage
            ]
      else
        [ p [] [ text "Waiting for JavaScript..." ]
        ]
    )
