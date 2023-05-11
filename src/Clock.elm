module Clock exposing (handleTick, millisToSeconds)

import Message exposing (Msg(..))
import Model exposing (Model)
import Time exposing (Posix)


handleTick : Posix -> Model -> ( Model, Cmd Msg )
handleTick newTime model =
    ( { model | currentTime = newTime }
    , Cmd.none
    )


millisToSeconds : Int -> Int
millisToSeconds millis =
    round (toFloat millis / 1000)
