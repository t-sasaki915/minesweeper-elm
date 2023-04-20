module Types exposing (..)

import Browser
import Browser.Navigation as Nav
import Difficulty exposing (Difficulty)
import Url exposing (Url)


type Msg
    = UrlRequest Browser.UrlRequest
    | UrlChange Url
    | RequestDataToJS
    | ReceiveDataFromJS String
    | CellClick Coordinate
    | ToggleFlagPlaceMode
    | RestartGame
    | MineCoordGenerate Coordinate


type alias Coordinate =
    { x : Int, y : Int }


type alias Model =
    { difficulty : Maybe Difficulty
    , path : String
    , isGameStarted : Bool
    , isGameOver : Bool
    , inFlagPlaceMode : Bool
    , openedCellCoords : List Coordinate
    , flaggedCellCoords : List Coordinate
    , mineCoords : List Coordinate
    , navKey : Nav.Key
    , difficultyReceived : Bool
    , pathReceived : Bool
    }


createEmptyModel : Nav.Key -> Model
createEmptyModel navKey =
    { difficulty = Nothing
    , path = ""
    , isGameStarted = False
    , isGameOver = False
    , inFlagPlaceMode = False
    , openedCellCoords = []
    , flaggedCellCoords = []
    , mineCoords = []
    , navKey = navKey
    , difficultyReceived = False
    , pathReceived = False
    }
