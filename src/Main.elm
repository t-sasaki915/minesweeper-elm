port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Clock exposing (handleTick)
import Components exposing (..)
import GameLogic exposing (..)
import Html exposing (br, h1, p, text)
import Html.Attributes exposing (..)
import JSCommunication exposing (..)
import Message exposing (Msg(..))
import MineGenerate exposing (handleMineCoordGenerate)
import Model exposing (Model, emptyModel)
import Task
import Time
import UIConditions exposing (Screen(..), currentScreen)
import URLUpdate exposing (..)
import Url exposing (Url)
import Util exposing (intoCmd)


port sendData : String -> Cmd msg


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
init _ _ navKey =
    ( emptyModel navKey
    , Cmd.batch
        [ intoCmd RequestDataToJS
        , Task.perform Tick Time.now
        ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg =
    case msg of
        UrlChange url ->
            handleURLChange url

        UrlRequest req ->
            handleURLRequest req

        RequestDataToJS ->
            handleRequestDataToJS sendData

        ReceiveDataFromJS data ->
            handleReceiveDataFromJS data

        CellClick coord ->
            handleCellClick coord

        ToggleFlagPlaceMode ->
            handleToggleFlagPlaceMode

        RestartGame ->
            handleRestartGame

        MineCoordGenerate coord ->
            handleMineCoordGenerate coord

        ToggleFlag coord ->
            handleToggleFlag coord

        ShowAlert message ->
            handleShowAlert sendData message

        Tick newTime ->
            handleTick newTime


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ receiveData ReceiveDataFromJS
        , Time.every 1000 Tick
        ]


view : Model -> Browser.Document Msg
view model =
    let
        content =
            case currentScreen model of
                GameScreen ->
                    [ gameScreen model
                    , br [] []
                    , difficultySelector model
                    , br [] []
                    , aboutPage
                    ]

                UnknownDifficultyScreen ->
                    [ h1 [] [ text "Unknown Difficulty." ]
                    , difficultySelector model
                    , br [] []
                    , aboutPage
                    ]

                WaitingForJSScreen ->
                    [ p [] [ text "Waiting for JavaScript..." ]
                    ]

                NoScreen ->
                    []
    in
    Browser.Document "Minesweeper" content
