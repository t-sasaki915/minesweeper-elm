module URLUpdate exposing (..)

import Browser
import Browser.Navigation as Nav
import Message exposing (Msg(..))
import Model exposing (Model, emptyModel)
import Url exposing (Url)
import Util exposing (intoCmd)


handleURLChange : Url -> Model -> ( Model, Cmd Msg )
handleURLChange _ model =
    ( emptyModel model.navKey, intoCmd RequestDataToJS )


handleURLRequest : Browser.UrlRequest -> Model -> ( Model, Cmd Msg )
handleURLRequest req model =
    case req of
        Browser.Internal url ->
            ( model, Nav.pushUrl model.navKey <| Url.toString url )

        Browser.External url ->
            ( model, Nav.load url )
