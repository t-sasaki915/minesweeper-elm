module Types exposing ( .. )

import Browser
import Url exposing ( Url )

import Difficulty exposing ( Difficulty )

type Msg
  = UrlRequest Browser.UrlRequest
  | UrlChange Url
  | ReceiveDataFromJS String

type alias Model =
    { difficulty : Maybe Difficulty
    , path : String
    , difficultyReceived : Bool
    , pathReceived : Bool
    }