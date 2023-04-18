module GameLogic exposing (..)

import Types exposing (..)


handleToggleFlagPlaceMode : Model -> ( Model, Cmd Msg )
handleToggleFlagPlaceMode model =
    if model.inFlagPlaceMode then
        ( { model | inFlagPlaceMode = False }
        , Cmd.none
        )

    else
        ( { model | inFlagPlaceMode = True }
        , Cmd.none
        )


handleRestartGame : Model -> ( Model, Cmd Msg )
handleRestartGame model =
    ( model, Cmd.none )
