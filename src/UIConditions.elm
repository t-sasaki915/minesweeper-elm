module UIConditions exposing
    ( CellClass(..)
    , InnerIcon(..)
    , cellClassAt
    , innerIconAt
    )

import Coordinate exposing (Coordinate)
import ListUtil
import LogicConditions exposing (..)
import Model exposing (Model)


type CellClass
    = CellOpened
    | CellNotOpened
    | CellCause
    | NoClass


type InnerIcon
    = NoIcon
    | FlagIcon
    | FakeFlagIcon
    | WrongFlagIcon
    | MineIcon
    | NumberIcon


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


innerIconAt : Coordinate -> Model -> InnerIcon
innerIconAt coord model =
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


fAll : List Bool -> Bool
fAll boolList =
    ListUtil.forAll (\x -> x) boolList


shouldRenderFlagIcon : Coordinate -> Model -> Bool
shouldRenderFlagIcon coord model =
    if model.isGameOver then
        fAll
            [ isFlagged coord model
            , isMine coord model
            ]

    else
        fAll
            [ notOpened coord model
            , isFlagged coord model
            ]


shouldRenderFakeFlagIcon : Coordinate -> Model -> Bool
shouldRenderFakeFlagIcon coord model =
    if model.isGameOver then
        False

    else
        fAll
            [ model.inFlagPlaceMode
            , notOpened coord model
            , notFlagged coord model
            ]


shouldRenderWrongFlagIcon : Coordinate -> Model -> Bool
shouldRenderWrongFlagIcon coord model =
    if model.isGameOver then
        fAll
            [ isFlagged coord model
            , notMine coord model
            ]

    else
        False


shouldRenderNumberIcon : Coordinate -> Model -> Bool
shouldRenderNumberIcon coord model =
    if model.isGameOver then
        fAll
            [ notFlagged coord model
            , notMine coord model
            , isOpened coord model
            ]

    else
        isOpened coord model


shouldRenderMineIcon : Coordinate -> Model -> Bool
shouldRenderMineIcon coord model =
    if model.isGameOver then
        fAll
            [ notFlagged coord model
            , isMine coord model
            ]

    else
        False


shouldClassNameBeCellOpened : Coordinate -> Model -> Bool
shouldClassNameBeCellOpened coord model =
    if model.isGameOver then
        ListUtil.contains True
            [ fAll
                [ isOpened coord model
                , notCause coord model
                ]
            , fAll
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
        ListUtil.contains True
            [ fAll
                [ notOpened coord model
                , notCause coord model
                , notMine coord model
                ]
            , fAll
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
