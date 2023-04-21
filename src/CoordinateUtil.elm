module CoordinateUtil exposing (around3x3)

import Types exposing (Coordinate)


around3x3 : Coordinate -> List Coordinate
around3x3 centre =
    let
        x =
            centre.x

        y =
            centre.y
    in
    [ Coordinate (x - 1) (y - 1)
    , Coordinate x (y - 1)
    , Coordinate (x + 1) (y - 1)
    , Coordinate (x - 1) y
    , Coordinate (x + 1) y
    , Coordinate (x - 1) (y + 1)
    , Coordinate x (y + 1)
    , Coordinate (x + 1) (y + 1)
    ]
