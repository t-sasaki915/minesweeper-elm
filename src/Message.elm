module Message exposing (Msg(..))

import Browser
import Coordinate exposing (Coordinate)
import Time
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
    | ShowAlert String
    | Tick Time.Posix
