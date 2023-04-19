module Util exposing (..)

import Difficulty exposing (Difficulty, defaultDifficulty)
import Html exposing (a)
import Types exposing (..)


difficultyLinkURL : Model -> Difficulty -> String
difficultyLinkURL model diff =
    if diff == defaultDifficulty then
        model.path

    else
        model.path ++ "?d=" ++ diff.name


isExist : (a -> Bool) -> List a -> Bool
isExist test list =
    case List.head (List.filter test list) of
        Just _ ->
            True

        Nothing ->
            False


listWith : a -> List a -> List a
listWith a list =
    a :: list


listWithout : a -> List a -> List a
listWithout a list =
    List.filter (\x -> not (x == a)) list


isCellOpened : Coordinate -> Model -> Bool
isCellOpened coord model =
    isExist (\c -> c == coord) model.openedCellCoords


isCellFlagged : Coordinate -> Model -> Bool
isCellFlagged coord model =
    isExist (\c -> c == coord) model.flaggedCellCoords
