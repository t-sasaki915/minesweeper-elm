module ModelUtil exposing (..)

import Browser.Navigation as Nav
import ListUtil
import Types exposing (Coordinate, Model)


emptyModel : Nav.Key -> Model
emptyModel navKey =
    { difficulty = Nothing
    , path = ""
    , isGameStarted = False
    , isGameOver = False
    , inFlagPlaceMode = False
    , openedCellCoords = []
    , flaggedCellCoords = []
    , mineCoords = []
    , noMineCoords = []
    , causeCoord = Nothing
    , navKey = navKey
    , difficultyReceived = False
    , pathReceived = False
    }


isCellOpened : Coordinate -> Model -> Bool
isCellOpened coord model =
    ListUtil.contains coord model.openedCellCoords


isCellFlagged : Coordinate -> Model -> Bool
isCellFlagged coord model =
    ListUtil.contains coord model.flaggedCellCoords


isMine : Coordinate -> Model -> Bool
isMine coord model =
    ListUtil.contains coord model.mineCoords
