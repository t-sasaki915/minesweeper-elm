module Model exposing
    ( Model
    , emptyModel
    , isCellFlagged
    , isCellOpened
    , isMine
    , mineCountAt
    , notCellFlagged
    , notCellOpened
    , notMine
    )

import Browser.Navigation as Nav
import Coordinate exposing (Coordinate, around3x3)
import Difficulty exposing (Difficulty)
import ListUtil


type alias Model =
    { difficulty : Maybe Difficulty
    , path : String
    , isGameStarted : Bool
    , isGameOver : Bool
    , inFlagPlaceMode : Bool
    , openedCellCoords : List Coordinate
    , flaggedCellCoords : List Coordinate
    , mineCoords : List Coordinate
    , noMineCoords : List Coordinate
    , causeCoord : Maybe Coordinate
    , navKey : Nav.Key
    , difficultyReceived : Bool
    , pathReceived : Bool
    }


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


notCellOpened : Coordinate -> Model -> Bool
notCellOpened coord =
    isCellOpened coord >> not


isCellFlagged : Coordinate -> Model -> Bool
isCellFlagged coord model =
    ListUtil.contains coord model.flaggedCellCoords


notCellFlagged : Coordinate -> Model -> Bool
notCellFlagged coord =
    isCellFlagged coord >> not


isMine : Coordinate -> Model -> Bool
isMine coord model =
    ListUtil.contains coord model.mineCoords


notMine : Coordinate -> Model -> Bool
notMine coord =
    isMine coord >> not


mineCountAt : Coordinate -> Model -> Int
mineCountAt coord model =
    ListUtil.numberOf True
        (List.map
            (\c -> isMine c model)
            (around3x3 coord)
        )
