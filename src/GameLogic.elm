module GameLogic exposing (..)

import Types exposing (..)
import Util exposing (listWith, listWithout)


handleCellClick : Coordinate -> Model -> ( Model, Cmd Msg )
handleCellClick coord model =
    let
        inFlagPlaceMode =
            model.inFlagPlaceMode

        isOpened =
            Util.isCellOpened coord model

        isFlagged =
            Util.isCellFlagged coord model
    in
    if inFlagPlaceMode then
        if not isOpened then
            if isFlagged then
                ( { model | flaggedCellCoords = listWithout coord model.flaggedCellCoords }
                , Cmd.none
                )

            else
                ( { model | flaggedCellCoords = listWith coord model.flaggedCellCoords }
                , Cmd.none
                )

        else
            ( model, Cmd.none )

    else if not isOpened then
        if not isFlagged then
            ( { model | openedCellCoords = listWith coord model.openedCellCoords }
            , Cmd.none
            )

        else
            ( model, Cmd.none )

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
    ( { model | inFlagPlaceMode = False, openedCellCoords = [], flaggedCellCoords = [] }
    , Cmd.none
    )
