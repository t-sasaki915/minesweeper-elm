module JSCommunicator exposing
    ( processMessageFromJS
    , requestAlertToJS
    , requestDataToJS
    )

import Difficulty
import List exposing (map)
import Model exposing (Model)
import StringUtil exposing (takeAfter, takeBefore)


type alias JSMessage =
    { key : String
    , value : String
    }


jsMsgToString : JSMessage -> String
jsMsgToString jsmessage =
    jsmessage.key ++ "=" ++ jsmessage.value


sendJSMessage : JSMessage -> (String -> Cmd msg) -> Cmd msg
sendJSMessage jsMsg messenger =
    messenger (jsMsgToString jsMsg)


sendJSMessages : List JSMessage -> (String -> Cmd msg) -> Cmd msg
sendJSMessages jsMsgs messenger =
    Cmd.batch (map messenger (map jsMsgToString jsMsgs))


requestDataToJS : (String -> Cmd msg) -> Cmd msg
requestDataToJS =
    sendJSMessages
        [ JSMessage "RequestData" "Difficulty"
        , JSMessage "RequestData" "Path"
        ]


requestAlertToJS : String -> (String -> Cmd msg) -> Cmd msg
requestAlertToJS content =
    sendJSMessage (JSMessage "ShowAlert" content)


processMessageFromJS : String -> Model -> ( Model, Cmd msg )
processMessageFromJS message model =
    let
        key =
            takeBefore "=" message

        value =
            takeAfter "=" message
    in
    case key of
        "Difficulty" ->
            case Difficulty.fromString value of
                Just diff ->
                    ( { model
                        | difficulty = diff
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
