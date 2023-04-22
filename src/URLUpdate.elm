module URLUpdate exposing (..)

import Browser
import Browser.Navigation as Nav
import Message exposing (Msg(..))
import Model exposing (Model, emptyModel)
import Task
import Url exposing (Url)


handleURLChange : Url -> Model -> ( Model, Cmd Msg )
handleURLChange _ model =
    ( emptyModel model.navKey, Task.perform (always RequestDataToJS) (Task.succeed ()) )


handleURLRequest : Browser.UrlRequest -> Model -> ( Model, Cmd Msg )
handleURLRequest req model =
    case req of
        Browser.Internal url ->
            ( model, Nav.pushUrl model.navKey <| Url.toString url )

        Browser.External url ->
            ( model, Nav.load url )
