module Model exposing (..)

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
            (around3x3 coord)
        )
