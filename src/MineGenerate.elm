module MineGenerate exposing
    ( generateMineCoord
    , handleMineCoordGenerate
    )

import Coordinate exposing (Coordinate)
import ListUtil
import Message exposing (Msg(..))
import Model exposing (Model)
import Random


isMineGeneratedEnough : Model -> Bool
isMineGeneratedEnough model =
    List.length model.mineCoords >= model.difficulty.mineCount


canPlaceMine : Coordinate -> Model -> Bool
canPlaceMine coord model =
    ListUtil.forAll (\x -> x)
        [ not (ListUtil.contains coord model.mineCoords)
        , not (ListUtil.contains coord model.noMineCoords)
        ]


handleMineCoordGenerate : Coordinate -> Model -> ( Model, Cmd Msg )
handleMineCoordGenerate coord model =
    if isMineGeneratedEnough model then
        ( { model | isGameStarted = True }
        , Cmd.none
        )

    else if canPlaceMine coord model then
        ( { model | mineCoords = ListUtil.listWith coord model.mineCoords }
        , generateMineCoord model
        )

    else
        ( model
        , generateMineCoord model
        )


generateMineCoord : Model -> Cmd Msg
generateMineCoord model =
    let
        width =
            model.difficulty.width

        height =
            model.difficulty.height
    in
    Random.generate
        MineCoordGenerate
        (Random.map2 (\x -> \y -> Coordinate x y)
            (Random.int 0 (width - 1))
            (Random.int 0 (height - 1))
        )
