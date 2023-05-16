module Cell exposing
    ( CellClass(..)
    , CellIcon(..)
    , cellClassAt
    , cellIconAt
    )

import Coordinate exposing (Coordinate)
import ListUtil exposing (contains, identityForAll)
import LogicConditions exposing (..)
import Model exposing (Model)


type CellClass
    = CellOpened
    | CellNotOpened
    | CellCause
    | NoClass


type CellIcon
    = FlagIcon
    | FakeFlagIcon
    | WrongFlagIcon
    | MineIcon
    | NumberIcon
    | NoIcon


cellClassAt : Coordinate -> Model -> CellClass
cellClassAt coord model =
    if shouldClassNameBeCellOpened coord model then
        CellOpened

    else if shouldClassNameBeCellNotOpened coord model then
        CellNotOpened

    else if shouldClassNameBeCellCause coord model then
        CellCause

    else
        NoClass


cellIconAt : Coordinate -> Model -> CellIcon
cellIconAt coord model =
    if shouldRenderFlagIcon coord model then
        FlagIcon

    else if shouldRenderFakeFlagIcon coord model then
        FakeFlagIcon

    else if shouldRenderWrongFlagIcon coord model then
        WrongFlagIcon

    else if shouldRenderMineIcon coord model then
        MineIcon

    else if shouldRenderNumberIcon coord model then
        NumberIcon

    else
        NoIcon


shouldRenderFlagIcon : Coordinate -> Model -> Bool
shouldRenderFlagIcon coord model =
    if model.isGameOver then
        identityForAll
            [ isFlagged coord model
            , isMine coord model
            ]

    else
        identityForAll
            [ notOpened coord model
            , isFlagged coord model
            ]


shouldRenderFakeFlagIcon : Coordinate -> Model -> Bool
shouldRenderFakeFlagIcon coord model =
    if model.isGameOver then
        False

    else
        identityForAll
            [ model.inFlagPlaceMode
            , notOpened coord model
            , notFlagged coord model
            ]


shouldRenderWrongFlagIcon : Coordinate -> Model -> Bool
shouldRenderWrongFlagIcon coord model =
    if model.isGameOver then
        identityForAll
            [ isFlagged coord model
            , notMine coord model
            ]

    else
        False


shouldRenderNumberIcon : Coordinate -> Model -> Bool
shouldRenderNumberIcon coord model =
    if model.isGameOver then
        identityForAll
            [ notFlagged coord model
            , notMine coord model
            , isOpened coord model
            ]

    else
        isOpened coord model


shouldRenderMineIcon : Coordinate -> Model -> Bool
shouldRenderMineIcon coord model =
    if model.isGameOver then
        identityForAll
            [ notFlagged coord model
            , isMine coord model
            ]

    else
        False


shouldClassNameBeCellOpened : Coordinate -> Model -> Bool
shouldClassNameBeCellOpened coord model =
    if model.isGameOver then
        contains True
            [ identityForAll
                [ isOpened coord model
                , notCause coord model
                ]
            , identityForAll
                [ notOpened coord model
                , notCause coord model
                , notFlagged coord model
                , isMine coord model
                ]
            ]

    else
        isOpened coord model


shouldClassNameBeCellNotOpened : Coordinate -> Model -> Bool
shouldClassNameBeCellNotOpened coord model =
    if model.isGameOver then
        contains True
            [ identityForAll
                [ notOpened coord model
                , notCause coord model
                , notMine coord model
                ]
            , identityForAll
                [ notOpened coord model
                , notCause coord model
                , isFlagged coord model
                ]
            ]

    else
        notOpened coord model


shouldClassNameBeCellCause : Coordinate -> Model -> Bool
shouldClassNameBeCellCause coord model =
    if model.isGameOver then
        isCause coord model

    else
        False
