module GameLogic exposing
    ( handleCellClick
    , handleCellOpen
    , handleRestartGame
    , handleToggleFlag
    , handleToggleFlagPlaceMode
    )

import Coordinate exposing (Coordinate, around3x3)
import ListUtil
import Message exposing (Msg(..))
import MineGenerate exposing (generateMineCoord)
import Model exposing (Model, emptyModel)
import Util exposing (intoCmd)


handleToggleFlagPlaceMode : Model -> ( Model, Cmd Msg )
handleToggleFlagPlaceMode model =
    if model.isGameOver then
        ( model, Cmd.none )

    else
        ( { model | inFlagPlaceMode = not model.inFlagPlaceMode }
        , Cmd.none
        )


handleRestartGame : Model -> ( Model, Cmd Msg )
handleRestartGame model =
    let
        newModel =
            emptyModel model.navKey
    in
    ( { newModel
        | difficulty = model.difficulty
        , path = model.path
        , difficultyReceived = model.difficultyReceived
        , pathReceived = model.pathReceived
        , unknownDifficulty = model.unknownDifficulty
      }
    , Cmd.none
    )


handleCellClick : Coordinate -> Model -> ( Model, Cmd Msg )
handleCellClick coord model =
    if model.isGameOver then
        ( model, Cmd.none )

    else if model.inFlagPlaceMode then
        ( model, intoCmd (ToggleFlag coord) )

    else if model.isGameStarted then
        ( model, intoCmd (CellOpen coord) )

    else
        ( { model
            | startCoord = coord
            , noMineCoords = around3x3 coord
          }
        , generateMineCoord model
        )


handleToggleFlag : Coordinate -> Model -> ( Model, Cmd Msg )
handleToggleFlag coord model =
    if ListUtil.contains coord model.flaggedCellCoords then
        ( { model | flaggedCellCoords = ListUtil.listWithout coord model.flaggedCellCoords }
        , Cmd.none
        )

    else
        ( { model | flaggedCellCoords = ListUtil.listWith coord model.flaggedCellCoords }
        , Cmd.none
        )


handleCellOpen : Coordinate -> Model -> ( Model, Cmd Msg )
handleCellOpen coord model =
    if ListUtil.contains coord model.mineCoords then
        ( { model | isGameOver = True, causeCoord = Just coord }
        , Cmd.none
        )

    else
        ( { model | openedCoords = ListUtil.listWith coord model.openedCoords }
        , Cmd.none
        )
