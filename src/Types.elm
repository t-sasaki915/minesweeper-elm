module Types exposing (..)

import Browser
import Difficulty exposing (Difficulty)
import Url exposing (Url)


type Msg
    = UrlRequest Browser.UrlRequest
    | UrlChange Url
    | ReceiveDataFromJS String
    | ToggleFlagPlaceMode
    | RestartGame


type alias Model =
    { difficulty : Maybe Difficulty
    , path : String
    , difficultyReceived : Bool
    , pathReceived : Bool
    , inFlagPlaceMode : Bool
    }
