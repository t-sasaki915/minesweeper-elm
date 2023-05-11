module Model exposing
    ( Model
    , emptyModel
    )

import Browser.Navigation as Nav
import Coordinate exposing (Coordinate)
import Difficulty exposing (Difficulty, defaultDifficulty)
import Time exposing (Posix, millisToPosix)


type alias Model =
    { difficulty : Difficulty
    , path : String
    , isGameStarted : Bool
    , isGameOver : Bool
    , isGameCleared : Bool
    , inFlagPlaceMode : Bool
    , openedCoords : List Coordinate
    , flaggedCoords : List Coordinate
    , mineCoords : List Coordinate
    , noMineCoords : List Coordinate
    , startCoord : Coordinate
    , causeCoord : Coordinate
    , navKey : Nav.Key
    , difficultyReceived : Bool
    , pathReceived : Bool
    , unknownDifficulty : Bool
    , currentTime : Posix
    , startTime : Posix
    , gameOverTime : Posix
    }


emptyModel : Nav.Key -> Model
emptyModel navKey =
    { difficulty = defaultDifficulty
    , path = ""
    , isGameStarted = False
    , isGameOver = False
    , isGameCleared = False
    , inFlagPlaceMode = False
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
