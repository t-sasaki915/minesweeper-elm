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


type alias Coordinate =
    { x : Int, y : Int }


type alias Model =
    { difficulty : Maybe Difficulty
    , path : String
    , inFlagPlaceMode : Bool
    , openedCellCoords : List Coordinate
    , flaggedCellCoords : List Coordinate
    , navKey : Nav.Key
    , difficultyReceived : Bool
    , pathReceived : Bool
    }


createEmptyModel : Nav.Key -> Model
createEmptyModel navKey =
    { difficulty = Nothing
    , path = ""
    , inFlagPlaceMode = False
    , openedCellCoords = []
    , flaggedCellCoords = []
    , navKey = navKey
    , difficultyReceived = False
    , pathReceived = False
    }
