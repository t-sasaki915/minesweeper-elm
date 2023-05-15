module ActualCell exposing
    ( ActualCellClass
    , ActualCellIcon
    , actualizeCellClass
    , actualizeCellIcon
    )

import Cell exposing (CellClass(..), CellIcon(..))
import Html exposing (Html)
import Images exposing (..)
import Message exposing (Msg)
import Model exposing (Model)


type alias ActualCellClass =
    String


type alias ActualCellIcon =
    List (Html Msg)


actualizeCellClass : CellClass -> Model -> ActualCellClass
actualizeCellClass cellClass _ =
    case cellClass of
        CellOpened ->
            "cell cellOpened"

        CellNotOpened ->
            "cell cellNotOpened"

        CellCause ->
            "cell cellCause"

        NoClass ->
            ""


actualizeCellIcon : CellIcon -> Model -> ActualCellIcon
actualizeCellIcon cellIcon model =
    case cellIcon of
        FlagIcon ->
            [ flagIcon ]

        FakeFlagIcon ->
            [ fakeFlagIcon ]

        WrongFlagIcon ->
            [ wrongFlagIcon ]

        MineIcon ->
            [ mineIcon ]

        -- TODO
        NumberIcon ->
            [ numberIcon 1 ]

        NoIcon ->
            []
