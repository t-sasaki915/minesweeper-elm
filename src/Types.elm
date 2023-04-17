module Types exposing ( .. )

import Browser
import Url exposing ( Url )

import Difficulty exposing ( Difficulty )

type Msg
  = UrlRequest Browser.UrlRequest
  | UrlChange Url

type alias Model =
    { difficulty : Maybe Difficulty
    , path : String
    }