port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Components exposing (..)
import GameLogic exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import JSCommunication exposing (..)
import Message exposing (Msg(..))
import MineGenerate exposing (..)
import Model exposing (Model, emptyModel)
import Task
import URLUpdate exposing (..)
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
    , Task.perform (always RequestDataToJS) (Task.succeed ())
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
    Browser.Document "Minesweeper"
        (if model.difficultyReceived && model.pathReceived then
            if model.unknownDifficulty then
                [ h1 [] [ text "Unknown Difficulty." ]
                , difficultySelector model
                , br [] []
                , aboutPage
                ]

            else
                [ gameScreen model
                , br [] []
                , difficultySelector model
                , br [] []
                , aboutPage
                ]

         else
            [ p [] [ text "Waiting for JavaScript..." ]
            ]
        )
