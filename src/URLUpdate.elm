module URLUpdate exposing (..)

import Browser
import Browser.Navigation as Nav
import Types exposing (..)
import Url exposing (Url)


handleURLChange : Url -> Model -> ( Model, Cmd Msg )
handleURLChange _ model =
    ( model, Cmd.none )


handleURLRequest : Browser.UrlRequest -> Model -> ( Model, Cmd Msg )
handleURLRequest req model =
    case req of
        Browser.Internal url ->
            ( model, Nav.load (Url.toString url) )

        Browser.External url ->
            ( model, Nav.load url )
