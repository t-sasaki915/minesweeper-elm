module GameLogic exposing
    ( calcMineCountAt
    , handleCellClick
    , handleCellOpen
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
import Util exposing (intoCmd)


calcMineCountAt : Coordinate -> Model -> Int
calcMineCountAt coord model =
    ListUtil.numberOf True
        (List.map
            (\c -> isMine c model)
            (around3x3 coord)
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
      }
    , Cmd.none
    )


handleCellClick : Coordinate -> Model -> ( Model, Cmd Msg )
handleCellClick coord model =
    case currentGameStatus model of
        NotInFlagPlaceMode ->
            if notOpened coord model && notFlagged coord model then
                ( model, intoCmd (CellOpen coord) )

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
                , noMineCoords = around3x3 coord
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


handleCellOpen : Coordinate -> Model -> ( Model, Cmd Msg )
handleCellOpen coord model =
    if isMine coord model then
        ( { model | isGameOver = True, causeCoord = coord }
        , Cmd.none
        )

    else
        ( { model | openedCoords = ListUtil.listWith coord model.openedCoords }
        , Cmd.none
        )
