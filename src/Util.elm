module Util exposing (intoCmd)

import Task


intoCmd : msg -> Cmd msg
intoCmd msg =
    Task.perform (always msg) (Task.succeed ())
