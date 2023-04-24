port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Components exposing (..)
import GameLogic exposing (..)
import Html exposing (br, h1, p, text)
import Html.Attributes exposing (..)
import JSCommunication exposing (..)
import Message exposing (Msg(..))
import MineGenerate exposing (handleMineCoordGenerate)
import Model exposing (Model, emptyModel)
import UIConditions exposing (..)
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
    , intoCmd RequestDataToJS
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


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveData ReceiveDataFromJS


view : Model -> Browser.Document Msg
view model =
    let
        content =
            if shouldRenderGameScreen model then
                [ gameScreen model
                , br [] []
                , difficultySelector model
                , br [] []
                , aboutPage
                ]

            else if shouldRenderUnknownDifficultyScreen model then
                [ h1 [] [ text "Unknown Difficulty." ]
                , difficultySelector model
                , br [] []
                , aboutPage
                ]

            else if shouldRenderWaitingForJSScreen model then
                [ p [] [ text "Waiting for JavaScript..." ]
                ]

            else
                []
    in
    Browser.Document "Minesweeper" content
