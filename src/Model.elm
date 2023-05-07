module Model exposing
    ( Model
    , emptyModel
    , isCause
    , isCellFlagged
    , isCellOpened
    , isMine
    , mineCountAt
    , notCause
    , notCellFlagged
    , notCellOpened
    , notMine
    )

import Browser.Navigation as Nav
import Coordinate exposing (Coordinate, around3x3)
import Difficulty exposing (Difficulty, defaultDifficulty)
import ListUtil


type alias Model =
    { difficulty : Difficulty
    , path : String
    , isGameStarted : Bool
    , isGameOver : Bool
    , inFlagPlaceMode : Bool
    , openedCoords : List Coordinate
    , flaggedCoords : List Coordinate
    , mineCoords : List Coordinate
    , noMineCoords : List Coordinate
    , startCoord : Coordinate
    , causeCoord : Maybe Coordinate
    , navKey : Nav.Key
    , difficultyReceived : Bool
    , pathReceived : Bool
    , unknownDifficulty : Bool
    }


emptyModel : Nav.Key -> Model
emptyModel navKey =
    { difficulty = defaultDifficulty
    , path = ""
    , isGameStarted = False
    , isGameOver = False
    , inFlagPlaceMode = False
    , openedCoords = []
    , flaggedCoords = []
    , mineCoords = []
    , noMineCoords = []
    , startCoord = Coordinate -1 -1
    , causeCoord = Nothing
    , navKey = navKey
    , difficultyReceived = False
    , pathReceived = False
    , unknownDifficulty = False
    }


isCellOpened : Coordinate -> Model -> Bool
isCellOpened coord model =
    ListUtil.contains coord model.openedCoords


notCellOpened : Coordinate -> Model -> Bool
notCellOpened coord =
    isCellOpened coord >> not


isCellFlagged : Coordinate -> Model -> Bool
isCellFlagged coord model =
    ListUtil.contains coord model.flaggedCoords


notCellFlagged : Coordinate -> Model -> Bool
notCellFlagged coord =
    isCellFlagged coord >> not


isMine : Coordinate -> Model -> Bool
isMine coord model =
    ListUtil.contains coord model.mineCoords


notMine : Coordinate -> Model -> Bool
notMine coord =
    isMine coord >> not


isCause : Coordinate -> Model -> Bool
isCause coord model =
    case model.causeCoord of
        Just c ->
            c == coord

        Nothing ->
            False


notCause : Coordinate -> Model -> Bool
notCause coord =
    isCause coord >> not


mineCountAt : Coordinate -> Model -> Int
mineCountAt coord model =
    ListUtil.numberOf True
        (List.map
            (\c -> isMine c model)
            (around3x3 coord)
        )
