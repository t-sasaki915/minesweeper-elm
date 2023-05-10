module Message exposing (Msg(..))

import Browser
import Coordinate exposing (Coordinate)
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
    | ToggleFlag Coordinate
