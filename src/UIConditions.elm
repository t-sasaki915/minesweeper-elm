module UIConditions exposing
    ( shouldClassNameBeCellCause
    , shouldClassNameBeCellNotOpened
    , shouldClassNameBeCellOpened
    , shouldRenderFakeFlagIcon
    , shouldRenderFlagIcon
    , shouldRenderGameScreen
    , shouldRenderMineIcon
    , shouldRenderNumberIcon
    , shouldRenderUnknownDifficultyScreen
    , shouldRenderWaitingForJSScreen
    , shouldRenderWrongFlagIcon
    )

import Coordinate exposing (Coordinate)
import ListUtil
import Model exposing (..)


fAll : List Bool -> Bool
fAll boolList =
    ListUtil.forAll (\x -> x) boolList


shouldRenderGameScreen : Model -> Bool
shouldRenderGameScreen model =
    fAll
        [ model.difficultyReceived
        , model.pathReceived
        , not model.unknownDifficulty
        ]


shouldRenderUnknownDifficultyScreen : Model -> Bool
shouldRenderUnknownDifficultyScreen model =
    fAll
        [ model.difficultyReceived
        , model.pathReceived
        , model.unknownDifficulty
        ]


shouldRenderWaitingForJSScreen : Model -> Bool
shouldRenderWaitingForJSScreen model =
    not model.difficultyReceived || not model.pathReceived


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


shouldClassNameBeCellOpened : Coordinate -> Model -> Bool
shouldClassNameBeCellOpened coord model =
    if model.isGameOver then
        ListUtil.contains True
            [ fAll
                [ isCellOpened coord model
                , notCause coord model
                ]
            , fAll
                [ notCellOpened coord model
                , notCause coord model
                , notCellFlagged coord model
                , isMine coord model
                ]
            ]

    else
        isCellOpened coord model


shouldClassNameBeCellNotOpened : Coordinate -> Model -> Bool
shouldClassNameBeCellNotOpened coord model =
    if model.isGameOver then
        ListUtil.contains True
            [ fAll
                [ notCellOpened coord model
                , notCause coord model
                , notMine coord model
                ]
            , fAll
                [ notCellOpened coord model
                , notCause coord model
                , isCellFlagged coord model
                ]
            ]

    else
        notCellOpened coord model


shouldClassNameBeCellCause : Coordinate -> Model -> Bool
shouldClassNameBeCellCause coord model =
    if model.isGameOver then
        isCause coord model

    else
        False
