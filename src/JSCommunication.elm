module JSCommunication exposing
    ( handleReceiveDataFromJS
    , handleRequestDataToJS
    , handleShowAlert
    )

import Difficulty
import Message exposing (Msg)
import Model exposing (Model)
import StringUtil


handleRequestDataToJS : (String -> Cmd msg) -> Model -> ( Model, Cmd msg )
handleRequestDataToJS sender model =
    ( model
    , Cmd.batch
        [ sender "RequestData=Difficulty"
        , sender "RequestData=Path"
        ]
    )


handleShowAlert : (String -> Cmd msg) -> String -> Model -> ( Model, Cmd msg )
handleShowAlert sender message model =
    ( model, sender ("ShowAlert=" ++ message) )


handleReceiveDataFromJS : String -> Model -> ( Model, Cmd Msg )
handleReceiveDataFromJS data model =
    let
        key =
            StringUtil.takeBefore "=" data

        value =
            StringUtil.takeAfter "=" data
    in
    case key of
        "Difficulty" ->
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

        "Path" ->
            ( { model
                | path = value
                , pathReceived = True
              }
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )
