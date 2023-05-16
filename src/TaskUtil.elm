module TaskUtil exposing (performMsg, performMsgs)

import List exposing (map)
import Task exposing (perform)


performMsg : msg -> Cmd msg
performMsg msg =
    perform (always msg) (Task.succeed ())


performMsgs : List msg -> Cmd msg
performMsgs msgs =
    Cmd.batch (map performMsg msgs)
