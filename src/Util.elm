module Util exposing (..)

import Difficulty exposing (Difficulty, defaultDifficulty)
import Types exposing (..)


difficultyLinkURL : Model -> Difficulty -> String
difficultyLinkURL model diff =
    if diff == defaultDifficulty then
        model.path

    else
        model.path ++ "?d=" ++ diff.name


isCellOpened : Coordinate -> Model -> Bool
isCellOpened coord model =
    case List.head (List.filter (\c -> c == coord) model.openedCellCoords) of
        Just _ ->
            True

        Nothing ->
            False
