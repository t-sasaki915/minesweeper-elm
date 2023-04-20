module Util exposing (..)

import Difficulty exposing (Difficulty, defaultDifficulty)
import Types exposing (..)


difficultyLinkURL : Model -> Difficulty -> String
difficultyLinkURL model diff =
    if diff == defaultDifficulty then
        model.path

    else
        model.path ++ "?d=" ++ diff.name


contains : a -> List a -> Bool
contains a list =
    isExist (\x -> x == a) list


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
    contains coord model.openedCellCoords


isCellFlagged : Coordinate -> Model -> Bool
isCellFlagged coord model =
    contains coord model.flaggedCellCoords


isMine : Coordinate -> Model -> Bool
isMine coord model =
    contains coord model.mineCoords
