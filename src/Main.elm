port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Components exposing (..)
import GameLogic exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import JSCommunication exposing (..)
import Types exposing (..)
import URLUpdate exposing (..)
import Url exposing (Url)


port receiveData : (String -> msg) -> Sub msg


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


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ _ _ =
    ( { difficulty = Nothing
      , path = ""
      , difficultyReceived = False
      , pathReceived = False
      , inFlagPlaceMode = False
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg =
    case msg of
        UrlChange url ->
            handleURLChange url

        UrlRequest req ->
            handleURLRequest req

        ReceiveDataFromJS data ->
            handleReceiveDataFromJS data

        CellClick x y ->
            handleCellClick x y

        ToggleFlagPlaceMode ->
            handleToggleFlagPlaceMode

        RestartGame ->
            handleRestartGame


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.difficultyReceived && model.pathReceived then
        Sub.none

    else
        receiveData ReceiveDataFromJS


view : Model -> Browser.Document Msg
view model =
    Browser.Document "Minesweeper"
        (if model.difficultyReceived && model.pathReceived then
            case model.difficulty of
                Just diff ->
                    [ gameScreen model diff
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
