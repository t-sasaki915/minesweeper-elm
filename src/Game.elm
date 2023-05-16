module Game exposing
    ( mineCountAt
    , processCellClick
    , restartGame
    , toggleFlagPlaceMode
    )

import Coordinate exposing (Coordinate, around3x3)
import List exposing (filter, map)
import ListUtil exposing (numberOf, without)
import LogicConditions exposing (..)
import Message exposing (Msg(..))
import MineGenerator exposing (generateMine)
import Model exposing (Model, emptyModel)
import TaskUtil exposing (performMsgs)


mineCountAt : Coordinate -> Model -> Int
mineCountAt coord model =
    numberOf True
        (map (\c -> isMine c model) (around3x3 coord model.difficulty))


processCellClick : Coordinate -> Model -> ( Model, Cmd Msg )
processCellClick coord model =
    case currentGameStatus model of
        NotInFlagPlaceMode ->
            case cellStatusAt coord model of
                Opened ->
                    ( model, Cmd.none )

                Flagged ->
                    ( model, Cmd.none )

                NotFlagged ->
                    tryToOpen coord model

        InFlagPlaceMode ->
            case cellStatusAt coord model of
                Opened ->
                    ( model, Cmd.none )

                Flagged ->
                    removeFlag coord model

                NotFlagged ->
                    placeFlag coord model

        NotStarted ->
            startGame coord model

        GameOver ->
            ( model, Cmd.none )


toggleFlagPlaceMode : Model -> ( Model, Cmd Msg )
toggleFlagPlaceMode model =
    case currentGameStatus model of
        NotInFlagPlaceMode ->
            ( { model | inFlagPlaceMode = True }
            , Cmd.none
            )

        InFlagPlaceMode ->
            ( { model | inFlagPlaceMode = False }
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )


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


tryToOpen : Coordinate -> Model -> ( Model, Cmd Msg )
tryToOpen coord model =
    if isMine coord model then
        ( { model
            | isGameOver = True
            , causeCoord = coord
            , gameOverTime = model.currentTime
          }
        , Cmd.none
        )

    else
        open coord model


open : Coordinate -> Model -> ( Model, Cmd Msg )
open coord model =
    let
        newModel =
            { model | openedCoords = coord :: model.openedCoords }

        aroundOpenable =
            filter (\c -> isOpenable c newModel) (around3x3 coord newModel.difficulty)

        cmd =
            if mineCountAt coord newModel == 0 then
                performMsgs (map CellClick aroundOpenable)

            else
                Cmd.none
    in
    ( newModel, cmd )


placeFlag : Coordinate -> Model -> ( Model, Cmd Msg )
placeFlag coord model =
    ( { model | flaggedCoords = coord :: model.flaggedCoords }
    , Cmd.none
    )


removeFlag : Coordinate -> Model -> ( Model, Cmd Msg )
removeFlag coord model =
    ( { model | flaggedCoords = without coord model.flaggedCoords }
    , Cmd.none
    )


startGame : Coordinate -> Model -> ( Model, Cmd Msg )
startGame startCoord model =
    ( { model
        | startCoord = startCoord
        , noMineCoords = around3x3 startCoord model.difficulty
        , startTime = model.currentTime
      }
    , generateMine model
    )
