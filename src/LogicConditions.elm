module LogicConditions exposing
    ( GameStatus(..)
    , currentGameStatus
    , isCause
    , isFlagged
    , isMine
    , isOpened
    , notCause
    , notFlagged
    , notMine
    , notOpened
    )

import Coordinate exposing (Coordinate)
import ListUtil
import Model exposing (Model)


type GameStatus
    = Started
    | GameOver
    | NotStarted
    | InFlagPlaceMode


currentGameStatus : Model -> GameStatus
currentGameStatus model =
    if model.isGameOver then
        GameOver

    else if model.isGameStarted then
        if model.inFlagPlaceMode then
            InFlagPlaceMode

        else
            Started

    else
        NotStarted


merge : (a -> b -> c) -> (c -> d) -> a -> b -> d
merge f1 f2 a b =
    f2 (f1 a b)


isOpened : Coordinate -> Model -> Bool
isOpened coord model =
    ListUtil.contains coord model.openedCoords


isFlagged : Coordinate -> Model -> Bool
isFlagged coord model =
    ListUtil.contains coord model.flaggedCoords


isMine : Coordinate -> Model -> Bool
isMine coord model =
    ListUtil.contains coord model.mineCoords


isCause : Coordinate -> Model -> Bool
isCause coord model =
    coord == model.causeCoord


notOpened : Coordinate -> Model -> Bool
notOpened =
    merge isOpened not


notFlagged : Coordinate -> Model -> Bool
notFlagged =
    merge isFlagged not


notMine : Coordinate -> Model -> Bool
notMine =
    merge isMine not


notCause : Coordinate -> Model -> Bool
notCause =
    merge isCause not
