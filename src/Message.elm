module Message exposing (Msg(..))

import Browser
import Coordinate exposing (Coordinate)
import Time
import Url exposing (Url)


type Msg
    = UrlRequest Browser.UrlRequest
    | UrlChange Url
    | ReceiveDataFromJS String
    | CellClick Coordinate
    | ToggleFlagPlaceMode
    | RestartGame
    | MineCoordGenerate Coordinate
    | Tick Time.Posix
