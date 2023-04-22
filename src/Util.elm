module Util exposing (..)

import Coordinate exposing (Coordinate)
import Difficulty exposing (Difficulty, defaultDifficulty)
import Model exposing (Model)


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


count : (a -> Bool) -> List a -> Int
count test list =
    List.length (List.filter test list)


isCellOpened : Coordinate -> Model -> Bool
isCellOpened coord model =
    contains coord model.openedCellCoords


isCellFlagged : Coordinate -> Model -> Bool
isCellFlagged coord model =
    contains coord model.flaggedCellCoords


isMine : Coordinate -> Model -> Bool
isMine coord model =
    contains coord model.mineCoords


getAround3x3 : Coordinate -> List Coordinate
getAround3x3 coord =
    let
        x =
            coord.x

        y =
            coord.y
    in
    [ Coordinate (x - 1) (y - 1)
    , Coordinate x (y - 1)
    , Coordinate (x + 1) (y - 1)
    , Coordinate (x - 1) y
    , Coordinate (x + 1) y
    , Coordinate (x - 1) (y + 1)
    , Coordinate x (y + 1)
    , Coordinate (x + 1) (y + 1)
    ]


getMineCount : Coordinate -> Model -> Int
getMineCount coord model =
    count (\x -> x) (List.map (\c -> contains c model.mineCoords) (getAround3x3 coord))
