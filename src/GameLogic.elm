module GameLogic exposing
    ( calcMineCountAt
    , handleCellClick
    , handleRestartGame
    , handleToggleFlag
    , handleToggleFlagPlaceMode
    )

import Coordinate exposing (Coordinate, around3x3)
import ListUtil
import LogicConditions exposing (..)
import Message exposing (Msg(..))
import MineGenerate exposing (generateMineCoord)
import Model exposing (Model, emptyModel)
import Util exposing (intoBatchCmd, intoCmd)


calcMineCountAt : Coordinate -> Model -> Int
calcMineCountAt coord model =
    ListUtil.numberOf True
        (List.map
            (\c -> isMine c model)
            (around3x3 coord model.difficulty)
        )


handleToggleFlagPlaceMode : Model -> ( Model, Cmd Msg )
handleToggleFlagPlaceMode model =
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


handleRestartGame : Model -> ( Model, Cmd Msg )
handleRestartGame model =
    let
        newModel =
            emptyModel model.navKey
    in
    ( { newModel
        | difficulty = model.difficulty
        , path = model.path
        , difficultyReceived = model.difficultyReceived
        , pathReceived = model.pathReceived
        , unknownDifficulty = model.unknownDifficulty
        , currentTime = model.currentTime
      }
    , Cmd.none
    )


handleCellClick : Coordinate -> Model -> ( Model, Cmd Msg )
handleCellClick coord model =
    case currentGameStatus model of
        NotInFlagPlaceMode ->
            if isMine coord model then
                ( { model
                    | isGameOver = True
                    , isGameCleared = False
                    , causeCoord = coord
                    , gameOverTime = model.currentTime
                  }
                , Cmd.none
                )

            else if notOpened coord model && notFlagged coord model then
                let
                    newModel =
                        { model | openedCoords = ListUtil.listWith coord model.openedCoords }

                    aroundOpenable =
                        List.filter (\c -> notOpened c newModel && notFlagged c newModel) (around3x3 coord newModel.difficulty)

                    command =
                        if isCleared newModel then
                            intoCmd (ShowAlert "Cleared.")

                        else if calcMineCountAt coord newModel == 0 then
                            intoBatchCmd (List.map CellClick aroundOpenable)

                        else
                            Cmd.none
                in
                ( if isCleared newModel then
                    { newModel
                        | isGameOver = True
                        , isGameCleared = True
                        , gameOverTime = newModel.currentTime
                    }

                  else
                    newModel
                , command
                )

            else
                ( model, Cmd.none )

        InFlagPlaceMode ->
            if notOpened coord model then
                ( model, intoCmd (ToggleFlag coord) )

            else
                ( model, Cmd.none )

        NotStarted ->
            ( { model
                | startCoord = coord
                , noMineCoords = around3x3 coord model.difficulty
                , startTime = model.currentTime
              }
            , generateMineCoord model
            )

        _ ->
            ( model, Cmd.none )


handleToggleFlag : Coordinate -> Model -> ( Model, Cmd Msg )
handleToggleFlag coord model =
    if isFlagged coord model then
        ( { model | flaggedCoords = ListUtil.listWithout coord model.flaggedCoords }
        , Cmd.none
        )

    else
        ( { model | flaggedCoords = ListUtil.listWith coord model.flaggedCoords }
        , Cmd.none
        )
