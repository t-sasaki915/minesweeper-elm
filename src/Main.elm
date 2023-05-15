port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Clock exposing (handleTick)
import Components exposing (..)
import GameLogic exposing (..)
import Html exposing (br, h1, p, text)
import Html.Attributes exposing (..)
import JSCommunicator exposing (..)
import Message exposing (Msg(..))
import MineGenerate exposing (handleMineCoordGenerate)
import Model exposing (Model, emptyModel)
import Task
import TaskUtil exposing (performMsg)
import Time
import UIConditions exposing (Screen(..), currentScreen)
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
update msg model =
    case msg of
        UrlChange _ ->
            ( emptyModel model.navKey
            , performMsg RequestDataToJS
            )

        UrlRequest req ->
            case req of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.navKey <| Url.toString url
                    )

                Browser.External url ->
                    ( model
                    , Nav.load url
                    )

        Tick newTime ->
            ( { model | currentTime = newTime }
            , Cmd.none
            )

        RequestDataToJS ->
            requestDataToJS model sendData

        RequestAlertToJS content ->
            requestAlertToJS content model sendData

        ReceiveDataFromJS data ->
            processMessageFromJS data model

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
