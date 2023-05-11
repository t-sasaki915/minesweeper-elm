module Clock exposing (handleTick, posixDelta, posixToSeconds)

import Message exposing (Msg(..))
import Model exposing (Model)
import Time exposing (Posix, millisToPosix, posixToMillis)


handleTick : Posix -> Model -> ( Model, Cmd Msg )
handleTick newTime model =
    ( { model | currentTime = newTime }
    , Cmd.none
    )


posixToSeconds : Posix -> Int
posixToSeconds p =
    round (toFloat (posixToMillis p) / 1000)


posixDelta : Posix -> Posix -> Posix
posixDelta p1 p2 =
    millisToPosix (posixToMillis p2 - posixToMillis p1)
