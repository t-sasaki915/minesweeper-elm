module Game exposing
    ( mineCountAt
    , processCellClick
    , restartGame
    , toggleFlagPlaceMode
    )

import Coordinate exposing (Coordinate, around3x3)
import List exposing (map)
import ListUtil exposing (numberOf)
import LogicConditions exposing (..)
import Message exposing (Msg(..))
import Model exposing (Model, emptyModel)


mineCountAt : Coordinate -> Model -> Int
mineCountAt coord model =
    numberOf True
        (map (\c -> isMine c model) (around3x3 coord model.difficulty))


processCellClick : Coordinate -> Model -> ( Model, Cmd Msg )
processCellClick coord model =
    ( model, Cmd.none )


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
