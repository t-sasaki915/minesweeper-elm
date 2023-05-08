module LogicConditions exposing
    ( isCause
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
