module GameLogic exposing (..)

import Coordinate exposing (Coordinate)
import Message exposing (Msg)
import MineGenerate exposing (..)
import Model exposing (Model, emptyModel)
import Util exposing (listWith, listWithout)


handleCellClick : Coordinate -> Model -> ( Model, Cmd Msg )
handleCellClick coord model =
    let
        inFlagPlaceMode =
            model.inFlagPlaceMode

        isGameStarted =
            model.isGameStarted

        isGameOver =
            model.isGameOver

        isOpened =
            Util.isCellOpened coord model

        isFlagged =
            Util.isCellFlagged coord model
    in
    if not isGameOver then
        if inFlagPlaceMode then
            if not isOpened then
                if isFlagged then
                    ( removeFlag coord model
                    , Cmd.none
                    )

                else
                    ( placeFlag coord model
                    , Cmd.none
                    )

            else
                ( model, Cmd.none )

        else if not isOpened then
            if not isFlagged then
                if isGameStarted then
                    ( openCell coord model, Cmd.none )

                else
                    let
                        newModel =
                            { model | noMineCoords = listWith coord (Util.getAround3x3 coord) }
                    in
                    ( openCell coord newModel
                    , generateCoord newModel
                    )

            else
                ( model, Cmd.none )

        else
            ( model, Cmd.none )

    else
        ( model, Cmd.none )


handleToggleFlagPlaceMode : Model -> ( Model, Cmd Msg )
handleToggleFlagPlaceMode model =
    if not model.isGameOver then
        if model.inFlagPlaceMode then
            ( exitFlagPlaceMode model
            , Cmd.none
            )

        else
            ( enterFlagPlaceMode model
            , Cmd.none
            )

    else
        ( model, Cmd.none )


handleRestartGame : Model -> ( Model, Cmd Msg )
handleRestartGame model =
    ( initGameState model
    , Cmd.none
    )


enterFlagPlaceMode : Model -> Model
enterFlagPlaceMode model =
    { model | inFlagPlaceMode = True }


exitFlagPlaceMode : Model -> Model
exitFlagPlaceMode model =
    { model | inFlagPlaceMode = False }


initGameState : Model -> Model
initGameState model =
    let
        newState =
            emptyModel model.navKey
    in
    { newState
        | difficulty = model.difficulty
        , path = model.path
        , difficultyReceived = True
        , pathReceived = True
    }


openCell : Coordinate -> Model -> Model
openCell coord model =
    if Util.isMine coord model then
        gameOver coord model

    else
        { model | openedCellCoords = listWith coord model.openedCellCoords }


placeFlag : Coordinate -> Model -> Model
placeFlag coord model =
    { model | flaggedCellCoords = listWith coord model.flaggedCellCoords }


removeFlag : Coordinate -> Model -> Model
removeFlag coord model =
    { model | flaggedCellCoords = listWithout coord model.flaggedCellCoords }


gameOver : Coordinate -> Model -> Model
gameOver coord model =
    { model
        | isGameOver = True
        , causeCoord = Just coord
        , openedCellCoords = listWith coord model.openedCellCoords
    }
