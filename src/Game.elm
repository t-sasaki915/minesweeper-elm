module Game exposing
    ( restartGame
    , toggleFlagPlaceMode
    )

import Coordinate exposing (Coordinate)
import Message exposing (Msg(..))
import Model exposing (Model, emptyModel)


toggleFlagPlaceMode : Model -> ( Model, Cmd Msg )
toggleFlagPlaceMode model =
    ( { model | inFlagPlaceMode = not model.inFlagPlaceMode }
    , Cmd.none
    )


restartGame : Model -> ( Model, Cmd Msg )
restartGame model =
    let
        newModel =
            emptyModel model.navKey
    in
    ( { newModel
        | difficulty = model.difficulty
        , path = model.path
        , difficultyReceived = model.difficultyReceived
        , pathReceived = model.pathReceived
        , currentTime = model.currentTime
        , unknownDifficulty = model.unknownDifficulty
      }
    , Cmd.none
    )
