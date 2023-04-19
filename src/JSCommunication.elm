module JSCommunication exposing (..)

import Difficulty exposing (defaultDifficulty)
import Types exposing (..)


handleRequestDataToJS : (String -> Cmd msg) -> Model -> ( Model, Cmd msg )
handleRequestDataToJS sender model =
    ( model, sender "REQ" )


handleReceiveDataFromJS : String -> Model -> ( Model, Cmd Msg )
handleReceiveDataFromJS data model =
    if String.startsWith "diff=" data then
        case String.dropLeft 5 data of
            "" ->
                ( { model | difficulty = Just defaultDifficulty, difficultyReceived = True }
                , Cmd.none
                )

            other ->
                ( { model | difficulty = Difficulty.fromString other, difficultyReceived = True }
                , Cmd.none
                )

    else if String.startsWith "path=" data then
        ( { model | path = String.dropLeft 5 data, pathReceived = True }
        , Cmd.none
        )

    else
        ( model, Cmd.none )
