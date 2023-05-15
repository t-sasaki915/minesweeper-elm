port module Main exposing (main)

--import GameLogic exposing (..)

import ActualScreen exposing (actualizeScreen)
import Browser exposing (Document, application)
import Browser.Navigation exposing (Key, load, pushUrl)
import FunctionUtil exposing (merge3)
import JSCommunicator exposing (processMessageFromJS, requestDataToJS)
import Message exposing (Msg(..))
import MineGenerator exposing (processNewMine)
import Model exposing (Model, emptyModel)
import Screen exposing (currentScreen)
import Task exposing (perform)
import Time
import Url exposing (Url)


port sendData : String -> Cmd msg


port receiveData : (String -> msg) -> Sub msg


main : Program () Model Msg
main =
    application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequest
        , onUrlChange = UrlChange
        }


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ _ navKey =
    ( emptyModel navKey
    , Cmd.batch
        [ requestDataToJS sendData
        , perform Tick Time.now
        ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange _ ->
            ( emptyModel model.navKey
            , requestDataToJS sendData
            )

        UrlRequest req ->
            case req of
                Browser.Internal url ->
                    ( model
                    , pushUrl model.navKey <| Url.toString url
                    )

                Browser.External url ->
                    ( model
                    , load url
                    )

        Tick newTime ->
            ( { model | currentTime = newTime }
            , Cmd.none
            )

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


view : Model -> Document Msg
view model =
    Document
        "Minesweeper"
        (merge3 currentScreen actualizeScreen model)
