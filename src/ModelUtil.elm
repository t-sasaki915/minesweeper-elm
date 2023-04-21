module ModelUtil exposing
    ( emptyModel
    , isCellFlagged
    , isCellOpened
    , isMine
    , mineCountAt
    )

import Browser.Navigation as Nav
import CoordinateUtil
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


mineCountAt : Coordinate -> Model -> Int
mineCountAt coord model =
    ListUtil.numberOf True
        (List.map
            (\c -> isMine c model)
            (CoordinateUtil.around3x3 coord)
        )
