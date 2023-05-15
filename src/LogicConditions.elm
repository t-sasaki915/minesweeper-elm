module LogicConditions exposing
    ( GameStatus(..)
    , currentGameStatus
    , isCause
    , isCleared
    , isFlagged
    , isMine
    , isOpenable
    , isOpened
    , isStartCoord
    , notCause
    , notFlagged
    , notMine
    , notOpenable
    , notOpened
    , notStartCoord
    )

import Coordinate exposing (Coordinate)
import ListUtil
import Model exposing (Model)


type GameStatus
    = NotInFlagPlaceMode
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
            NotInFlagPlaceMode

    else
        NotStarted


merge : (a -> b -> c) -> (c -> d) -> a -> b -> d
merge f1 f2 a b =
    f2 (f1 a b)


merge2 : (a -> b -> c) -> (a -> b -> d) -> (c -> d -> e) -> a -> b -> e
merge2 f1 f2 f3 a b =
    f3 (f1 a b) (f2 a b)


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


isStartCoord : Coordinate -> Model -> Bool
isStartCoord coord model =
    coord == model.startCoord


isCleared : Model -> Bool
isCleared model =
    let
        diff =
            model.difficulty

        cellArraySize =
            diff.width * diff.height
    in
    List.length model.openedCoords >= (cellArraySize - diff.mineCount)


isOpenable : Coordinate -> Model -> Bool
isOpenable =
    merge2 notOpened notFlagged (&&)


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


notStartCoord : Coordinate -> Model -> Bool
notStartCoord =
    merge isStartCoord not


notOpenable : Coordinate -> Model -> Bool
notOpenable =
    merge isOpenable not
