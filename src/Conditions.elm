module Conditions exposing
    ( shouldRenderFakeFlagIcon
    , shouldRenderFlagIcon
    , shouldRenderMineIcon
    , shouldRenderNumberIcon
    , shouldRenderWrongFlagIcon
    )

import Coordinate exposing (Coordinate)
import ListUtil
import Model exposing (..)


fAll : List Bool -> Bool
fAll boolList =
    ListUtil.forAll (\x -> x) boolList


shouldRenderFlagIcon : Coordinate -> Model -> Bool
shouldRenderFlagIcon coord model =
    if model.isGameOver then
        fAll
            [ isCellFlagged coord model
            , isMine coord model
            ]

    else
        fAll
            [ notCellOpened coord model
            , isCellFlagged coord model
            ]


shouldRenderFakeFlagIcon : Coordinate -> Model -> Bool
shouldRenderFakeFlagIcon coord model =
    if model.isGameOver then
        False

    else
        fAll
            [ model.inFlagPlaceMode
            , notCellOpened coord model
            , notCellFlagged coord model
            ]


shouldRenderWrongFlagIcon : Coordinate -> Model -> Bool
shouldRenderWrongFlagIcon coord model =
    if model.isGameOver then
        fAll
            [ isCellFlagged coord model
            , notMine coord model
            ]

    else
        False


shouldRenderNumberIcon : Coordinate -> Model -> Bool
shouldRenderNumberIcon coord model =
    if model.isGameOver then
        fAll
            [ notCellFlagged coord model
            , notMine coord model
            , isCellOpened coord model
            ]

    else
        isCellOpened coord model


shouldRenderMineIcon : Coordinate -> Model -> Bool
shouldRenderMineIcon coord model =
    if model.isGameOver then
        fAll
            [ notCellFlagged coord model
            , isMine coord model
            ]

    else
        False
