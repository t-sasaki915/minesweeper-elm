port module JSCommunicator exposing
    ( processMessageFromJS
    , requestAlertToJS
    , requestDataToJS
    , subscribeJSMessage
    )

import Difficulty
import List exposing (map)
import Message exposing (Msg(..))
import Model exposing (Model)
import StringUtil exposing (takeAfter, takeBefore)


port sendData : String -> Cmd msg


port receiveData : (String -> msg) -> Sub msg


type alias JSMessage =
    { key : String
    , value : String
    }


jsMsgToString : JSMessage -> String
jsMsgToString jsmessage =
    jsmessage.key ++ "=" ++ jsmessage.value


sendJSMessage : JSMessage -> Cmd msg
sendJSMessage jsMsg =
    sendData (jsMsgToString jsMsg)


sendJSMessages : List JSMessage -> Cmd msg
sendJSMessages jsMsgs =
    Cmd.batch (map sendJSMessage jsMsgs)


subscribeJSMessage : Sub Msg
subscribeJSMessage =
    receiveData ReceiveDataFromJS


requestDataToJS : Cmd msg
requestDataToJS =
    sendJSMessages
        [ JSMessage "RequestData" "Difficulty"
        , JSMessage "RequestData" "Path"
        ]


requestAlertToJS : String -> Cmd msg
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
