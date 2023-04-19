module JSCommunication exposing (..)

import Difficulty exposing (defaultDifficulty)
import Types exposing (..)


handleReceiveDataFromJS : String -> Model -> ( Model, Cmd Msg )
handleReceiveDataFromJS data model =
    if String.startsWith "diff=" data then
        case String.dropLeft 5 data of
            "" ->
                ( { model | difficulty = Just defaultDifficulty }
                , Cmd.none
                )

            other ->
                ( { model | difficulty = Difficulty.fromString other }
                , Cmd.none
                )

    else if String.startsWith "path=" data then
        ( { model | path = String.dropLeft 5 data }
        , Cmd.none
        )

    else
        ( model, Cmd.none )
