module Message exposing (Msg(..))

import Browser exposing (UrlRequest)
import Coordinate exposing (Coordinate)
import Time
import Url exposing (Url)


type Msg
    = UrlRequest UrlRequest
    | UrlChange Url
    | ReceiveDataFromJS String
    | CellClick Coordinate
    | ToggleFlagPlaceMode
    | ToggleChordMode
    | RestartGame
    | MineCoordGenerate Coordinate
    | Tick Time.Posix
