module Cell exposing (..)


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
