module JSCommunication exposing (..)

import Difficulty exposing (defaultDifficulty)
import Message exposing (Msg)
import Model exposing (Model)


handleRequestDataToJS : (String -> Cmd msg) -> Model -> ( Model, Cmd msg )
handleRequestDataToJS sender model =
    ( model, sender "REQ" )


handleReceiveDataFromJS : String -> Model -> ( Model, Cmd Msg )
handleReceiveDataFromJS data model =
    if String.startsWith "diff=" data then
        case String.dropLeft 5 data of
            "" ->
                ( { model | difficulty = defaultDifficulty, difficultyReceived = True, unknownDifficulty = False }
                , Cmd.none
                )

            other ->
                case Difficulty.fromString other of
                    Just d ->
                        ( { model | difficulty = d, difficultyReceived = True, unknownDifficulty = False }
                        , Cmd.none
                        )

                    Nothing ->
                        ( { model | difficultyReceived = True, unknownDifficulty = True }
                        , Cmd.none
                        )

    else if String.startsWith "path=" data then
        ( { model | path = String.dropLeft 5 data, pathReceived = True }
        , Cmd.none
        )

    else
        ( model, Cmd.none )
