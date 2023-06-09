module Model exposing
    ( Model
    , emptyModel
    )

import Browser.Navigation exposing (Key)
import Coordinate exposing (Coordinate)
import Difficulty exposing (Difficulty, defaultDifficulty)
import Time exposing (Posix, millisToPosix)


type alias Model =
    { difficulty : Difficulty
    , path : String
    , isGameStarted : Bool
    , isGameOver : Bool
    , inFlagPlaceMode : Bool
    , inChordMode : Bool
    , openedCoords : List Coordinate
    , flaggedCoords : List Coordinate
    , mineCoords : List Coordinate
    , noMineCoords : List Coordinate
    , startCoord : Coordinate
    , causeCoord : Coordinate
    , navKey : Key
    , difficultyReceived : Bool
    , pathReceived : Bool
    , unknownDifficulty : Bool
    , currentTime : Posix
    , startTime : Posix
    , gameOverTime : Posix
    }


emptyModel : Key -> Model
emptyModel navKey =
    { difficulty = defaultDifficulty
    , path = ""
    , isGameStarted = False
    , isGameOver = False
    , inFlagPlaceMode = False
    , inChordMode = False
    , openedCoords = []
    , flaggedCoords = []
    , mineCoords = []
    , noMineCoords = []
    , startCoord = Coordinate -1 -1
    , causeCoord = Coordinate -1 -1
    , navKey = navKey
    , difficultyReceived = False
    , pathReceived = False
    , unknownDifficulty = False
    , currentTime = millisToPosix 0
    , startTime = millisToPosix 0
    , gameOverTime = millisToPosix 0
    }
