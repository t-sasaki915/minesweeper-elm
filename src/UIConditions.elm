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
import LogicConditions exposing (..)
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
