port module Main exposing (main)

--import GameLogic exposing (..)

import ActualScreen
import Browser
import Browser.Navigation as Nav
import FunctionUtil exposing (merge3)
import JSCommunicator exposing (..)
import Message exposing (Msg(..))
import MineGenerator exposing (processNewMine)
import Model exposing (Model, emptyModel)
import Screen exposing (currentScreen)
import Task
import TaskUtil exposing (performMsg)
import Time
import Url exposing (Url)


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
        [ performMsg RequestDataToJS
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
            ( model, Cmd.none )

        ToggleFlagPlaceMode ->
            ( model, Cmd.none )

        RestartGame ->
            ( model, Cmd.none )

        MineCoordGenerate coord ->
            processNewMine coord model


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ receiveData ReceiveDataFromJS
        , Time.every 1000 Tick
        ]


view : Model -> Browser.Document Msg
view model =
    let
        screen =
            merge3 currentScreen ActualScreen.asActual model
    in
    Browser.Document "Minesweeper" screen
