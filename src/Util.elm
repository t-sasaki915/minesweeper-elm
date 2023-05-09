module Util exposing (intoBatchCmd, intoCmd)

import Task


intoCmd : msg -> Cmd msg
intoCmd msg =
    Task.perform (always msg) (Task.succeed ())


intoBatchCmd : List msg -> Cmd msg
intoBatchCmd msgs =
    Cmd.batch (List.map intoCmd msgs)
