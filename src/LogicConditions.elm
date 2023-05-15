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
import FunctionUtil exposing (merge1, merge2)
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
    merge1 isOpened not


notFlagged : Coordinate -> Model -> Bool
notFlagged =
    merge1 isFlagged not


notMine : Coordinate -> Model -> Bool
notMine =
    merge1 isMine not


notCause : Coordinate -> Model -> Bool
notCause =
    merge1 isCause not


notStartCoord : Coordinate -> Model -> Bool
notStartCoord =
    merge1 isStartCoord not


notOpenable : Coordinate -> Model -> Bool
notOpenable =
    merge1 isOpenable not
