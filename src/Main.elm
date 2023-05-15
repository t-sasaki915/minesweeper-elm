module Main exposing (main)

import ActualScreen exposing (actualizeScreen)
import Browser exposing (Document, application)
import Browser.Navigation exposing (Key, load, pushUrl)
import FunctionUtil exposing (merge3)
import Game exposing (..)
import JSCommunicator exposing (processMessageFromJS, requestDataToJS, subscribeJSMessage)
import Message exposing (Msg(..))
import MineGenerator exposing (processNewMine)
import Model exposing (Model, emptyModel)
import Screen exposing (currentScreen)
import Task exposing (perform)
import Time
import Url exposing (Url)


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
        [ requestDataToJS
        , perform Tick Time.now
        ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange _ ->
            ( emptyModel model.navKey
            , requestDataToJS
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
            toggleFlagPlaceMode model

        RestartGame ->
            restartGame model

        MineCoordGenerate coord ->
            processNewMine coord model


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ subscribeJSMessage
        , Time.every 1000 Tick
        ]


view : Model -> Document Msg
view model =
    Document
        "Minesweeper"
        (merge3 currentScreen actualizeScreen model)
