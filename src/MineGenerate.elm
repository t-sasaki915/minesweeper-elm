module MineGenerate exposing (..)

import Coordinate exposing (Coordinate)
import Difficulty exposing (defaultDifficulty)
import ListUtil
import Message exposing (Msg(..))
import Model exposing (Model)
import Random


handleMineCoordGenerate : Coordinate -> Model -> ( Model, Cmd Msg )
handleMineCoordGenerate coord model =
    if List.length model.mineCoords >= model.difficulty.mineCount then
        ( { model | isGameStarted = True }, Cmd.none )

    else if ListUtil.contains coord model.mineCoords || ListUtil.contains coord model.noMineCoords then
        ( model, generateCoord model )

    else
        ( { model | mineCoords = ListUtil.listWith coord model.mineCoords }
        , generateCoord model
        )


generateCoord : Model -> Cmd Msg
generateCoord model =
    let
        width =
            model.difficulty.width

        height =
            model.difficulty.height
    in
    Random.generate MineCoordGenerate (Random.map2 (\x -> \y -> Coordinate x y) (Random.int 0 (width - 1)) (Random.int 0 (height - 1)))
