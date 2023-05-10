module Clock exposing (handleTick)

import Message exposing (Msg(..))
import Model exposing (Model)
import Time


handleTick : Time.Posix -> Model -> ( Model, Cmd Msg )
handleTick newTime model =
    ( { model | currentTime = newTime }, Cmd.none )
