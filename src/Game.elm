module Game exposing
    ( mineCountAt
    , processCellClick
    , restartGame
    , toggleChordMode
    , toggleFlagPlaceMode
    )

import Coordinate exposing (Coordinate, around3x3)
import JSCommunicator exposing (requestAlertToJS)
import List exposing (filter, length, map)
import ListUtil exposing (exists, find, numberOf, without)
import LogicConditions exposing (..)
import MaybeUtil exposing (getOrElse)
import Message exposing (Msg(..))
import MineGenerator exposing (generateMine)
import Model exposing (Model, emptyModel)
import TaskUtil exposing (performMsgs)


mineCountAt : Coordinate -> Model -> Int
mineCountAt coord model =
    numberOf True
        (map (\c -> isMine c model) (around3x3 coord model.difficulty))


processCellClick : Coordinate -> Bool -> Model -> ( Model, Cmd Msg )
processCellClick coord byUser model =
    case currentGameStatus model of
        NotInFlagPlaceMode ->
            case currentChordModeStatus model of
                InChordMode ->
                    if byUser then
                        chordOpen coord model

                    else
                        normalOpen coord model

                NotInChordMode ->
                    normalOpen coord model

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


toggleChordMode : Model -> ( Model, Cmd Msg )
toggleChordMode model =
    case currentGameStatus model of
        GameOver ->
            ( model, Cmd.none )

        NotStarted ->
            ( model, Cmd.none )

        _ ->
            case currentChordModeStatus model of
                InChordMode ->
                    ( { model | inChordMode = False }
                    , Cmd.none
                    )

                NotInChordMode ->
                    ( { model | inChordMode = True }
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


normalOpen : Coordinate -> Model -> ( Model, Cmd Msg )
normalOpen coord model =
    case cellStatusAt coord model of
        Opened ->
            ( model, Cmd.none )

        Flagged ->
            ( model, Cmd.none )

        NotFlagged ->
            case tryToOpen coord model of
                CellOpenSuccess ->
                    open coord model

                CellOpenFailure ->
                    gameOver coord model

                GameClear ->
                    clearGame coord model


chordOpen : Coordinate -> Model -> ( Model, Cmd Msg )
chordOpen coord model =
    case cellStatusAt coord model of
        Opened ->
            let
                diff =
                    model.difficulty

                aroundFlagged =
                    filter (\c -> isFlagged c model) (around3x3 coord diff)

                aroundOpenable =
                    filter (\c -> isOpenable c model) (around3x3 coord diff)

                containsMine =
                    exists (\c -> isMine c model) aroundOpenable

                causeCoord =
                    getOrElse (Coordinate -1 -1) (find (\c -> isMine c model) aroundOpenable)

                mineCount =
                    mineCountAt coord model
            in
            if length aroundFlagged == mineCount then
                if containsMine then
                    gameOver causeCoord model

                else
                    ( model
                    , performMsgs (map (\c -> CellClick c False) aroundOpenable)
                    )

            else
                ( model, Cmd.none )

        Flagged ->
            ( model, Cmd.none )

        NotFlagged ->
            ( model, Cmd.none )


open : Coordinate -> Model -> ( Model, Cmd Msg )
open coord model =
    let
        newModel =
            { model | openedCoords = coord :: model.openedCoords }

        aroundOpenable =
            filter (\c -> isOpenable c newModel) (around3x3 coord newModel.difficulty)

        cmd =
            if mineCountAt coord newModel == 0 then
                performMsgs (map (\c -> CellClick c False) aroundOpenable)

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


clearGame : Coordinate -> Model -> ( Model, Cmd Msg )
clearGame coord model =
    ( { model
        | isGameOver = True
        , openedCoords = coord :: model.openedCoords
        , gameOverTime = model.currentTime
      }
    , requestAlertToJS "Cleared"
    )


gameOver : Coordinate -> Model -> ( Model, Cmd Msg )
gameOver coord model =
    ( { model
        | isGameOver = True
        , causeCoord = coord
        , gameOverTime = model.currentTime
      }
    , Cmd.none
    )
