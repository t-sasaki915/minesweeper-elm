module URLUpdate exposing ( .. )

import Browser
import Browser.Navigation as Nav
import Url exposing ( Url )

import Types exposing ( .. )

handleURLChange : Url -> Model -> ( Model, Cmd Msg )
handleURLChange _ model = ( model, Cmd.none )

handleURLRequest : Browser.UrlRequest -> Model -> ( Model, Cmd Msg )
handleURLRequest req model =
  case req of
    Browser.Internal url ->
      ( model, Nav.load (Url.toString url) )
    Browser.External url ->
      ( model, Nav.load url )
