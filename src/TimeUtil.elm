module TimeUtil exposing (posixDelta, posixToSeconds)

import Time exposing (Posix, millisToPosix, posixToMillis)


posixToSeconds : Posix -> Int
posixToSeconds p =
    round (toFloat (posixToMillis p) / 1000)


posixDelta : Posix -> Posix -> Posix
posixDelta p1 p2 =
    millisToPosix (posixToMillis p2 - posixToMillis p1)
