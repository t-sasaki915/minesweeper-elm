module JSCommunication exposing (..)

import Difficulty exposing (defaultDifficulty)
import Message exposing (Msg)
import Model exposing (Model)
import StringUtil


handleRequestDataToJS : (String -> Cmd msg) -> Model -> ( Model, Cmd msg )
handleRequestDataToJS sender model =
    ( model, sender "REQ" )


handleReceiveDataFromJS : String -> Model -> ( Model, Cmd Msg )
handleReceiveDataFromJS data model =
    let
        key =
            StringUtil.takeBefore "=" data

        value =
            StringUtil.takeAfter "=" data
    in
    case key of
        "diff" ->
            case Difficulty.fromString value of
                Just d ->
                    ( { model
                        | difficulty = d
                        , difficultyReceived = True
                        , unknownDifficulty = False
                      }
                    , Cmd.none
                    )

                Nothing ->
                    ( { model
                        | difficultyReceived = True
                        , unknownDifficulty = True
                      }
                    , Cmd.none
                    )

        "path" ->
            ( { model
                | path = value
                , pathReceived = True
              }
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )
