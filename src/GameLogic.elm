module GameLogic exposing (..)

import Types exposing (..)
import Util


handleCellClick : Coordinate -> Model -> ( Model, Cmd Msg )
handleCellClick coord model =
    if not (Util.isCellOpened coord model) then
        ( { model | openedCellCoords = coord :: model.openedCellCoords }
        , Cmd.none
        )

    else
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
    ( { model | inFlagPlaceMode = False, openedCellCoords = [] }
    , Cmd.none
    )
