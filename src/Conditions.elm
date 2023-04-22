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
            [ Model.isCellFlagged coord model
            , Model.isMine coord model
            ]

    else
        fAll
            [ not (Model.isCellOpened coord model)
            , Model.isCellFlagged coord model
            ]


shouldRenderFakeFlagIcon : Coordinate -> Model -> Bool
shouldRenderFakeFlagIcon coord model =
    if model.isGameOver then
        False

    else
        fAll
            [ not (Model.isCellOpened coord model)
            , not (Model.isCellFlagged coord model)
            , model.inFlagPlaceMode
            ]


shouldRenderWrongFlagIcon : Coordinate -> Model -> Bool
shouldRenderWrongFlagIcon coord model =
    if model.isGameOver then
        fAll
            [ Model.isCellFlagged coord model
            , not (Model.isMine coord model)
            ]

    else
        False


shouldRenderNumberIcon : Coordinate -> Model -> Bool
shouldRenderNumberIcon coord model =
    if model.isGameOver then
        fAll
            [ not (Model.isCellFlagged coord model)
            , not (Model.isMine coord model)
            , Model.isCellOpened coord model
            ]

    else
        Model.isCellOpened coord model


shouldRenderMineIcon : Coordinate -> Model -> Bool
shouldRenderMineIcon coord model =
    if model.isGameOver then
        fAll
            [ not (Model.isCellFlagged coord model)
            , Model.isMine coord model
            ]

    else
        False
