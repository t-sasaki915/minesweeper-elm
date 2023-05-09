module Model exposing
    ( Model
    , emptyModel
    )

import Browser.Navigation as Nav
import Coordinate exposing (Coordinate)
import Difficulty exposing (Difficulty, defaultDifficulty)


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
    , causeCoord : Coordinate
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
    , causeCoord = Coordinate -1 -1
    , navKey = navKey
    , difficultyReceived = False
    , pathReceived = False
    , unknownDifficulty = False
    }
