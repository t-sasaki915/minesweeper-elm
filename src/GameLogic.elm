module GameLogic exposing (..)

import Types exposing (..)


handleCellClick : Int -> Int -> Model -> ( Model, Cmd Msg )
handleCellClick x y model =
    ( model, Cmd.none )


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
    ( { model | inFlagPlaceMode = False }
    , Cmd.none
    )
