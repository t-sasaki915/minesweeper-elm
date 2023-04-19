module Types exposing (..)

import Browser
import Difficulty exposing (Difficulty)
import Url exposing (Url)


type Msg
    = UrlRequest Browser.UrlRequest
    | UrlChange Url
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
    }
