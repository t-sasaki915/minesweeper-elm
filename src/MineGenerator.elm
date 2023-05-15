module MineGenerator exposing
    ( generateMine
    , processNewMine
    )

import Coordinate exposing (Coordinate)
import List exposing (length)
import ListUtil exposing (identityForAll, notContains)
import LogicConditions exposing (notStartCoord)
import Message exposing (Msg(..))
import Model exposing (Model)
import Random
import TaskUtil exposing (performMsg)


type MineStatus
    = GeneratedEnough
    | CanPlace
    | CannotPlace


mineStatusAt : Coordinate -> Model -> MineStatus
mineStatusAt coord model =
    if generatedEnough model then
        GeneratedEnough

    else if canPlace coord model then
        CanPlace

    else
        CannotPlace


generatedEnough : Model -> Bool
generatedEnough model =
    length model.mineCoords >= model.difficulty.mineCount


canPlace : Coordinate -> Model -> Bool
canPlace coord model =
    identityForAll
        [ notContains coord model.mineCoords
        , notContains coord model.noMineCoords
        , notStartCoord coord model
        ]


processNewMine : Coordinate -> Model -> ( Model, Cmd Msg )
processNewMine coord model =
    case mineStatusAt coord model of
        GeneratedEnough ->
            ( { model | isGameStarted = True }
            , performMsg (CellClick model.startCoord)
            )

        CanPlace ->
            ( { model | mineCoords = coord :: model.mineCoords }
            , generateMine model
            )

        CannotPlace ->
            ( model
            , generateMine model
            )


generateMine : Model -> Cmd Msg
generateMine model =
    let
        width =
            model.difficulty.width

        height =
            model.difficulty.height
    in
    Random.generate
        MineCoordGenerate
        (Random.map2 Coordinate (Random.int 0 (width - 1)) (Random.int 0 (height - 1)))
