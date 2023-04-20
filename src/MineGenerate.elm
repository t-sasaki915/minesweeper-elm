module MineGenerate exposing (..)

import Difficulty exposing (defaultDifficulty)
import Random
import Types exposing (..)
import Util


handleMineCoordGenerate : Coordinate -> Model -> ( Model, Cmd Msg )
handleMineCoordGenerate coord model =
    let
        diff =
            case model.difficulty of
                Just d ->
                    d

                Nothing ->
                    defaultDifficulty
    in
    if List.length model.mineCoords >= diff.mineCount then
        ( { model | isGameStarted = True }, Cmd.none )

    else if Util.contains coord model.mineCoords then
        ( model, generateCoord model )

    else
        ( { model | mineCoords = Util.listWith coord model.mineCoords }
        , generateCoord model
        )


generateCoord : Model -> Cmd Msg
generateCoord model =
    let
        diff =
            case model.difficulty of
                Just d ->
                    d

                Nothing ->
                    defaultDifficulty

        width =
            diff.width

        height =
            diff.height
    in
    Random.generate MineCoordGenerate (Random.map2 (\x -> \y -> Coordinate x y) (Random.int 0 (width - 1)) (Random.int 0 (height - 1)))
