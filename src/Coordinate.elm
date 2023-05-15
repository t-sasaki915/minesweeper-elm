module Coordinate exposing (Coordinate, around3x3)

import Difficulty exposing (Difficulty)
import List exposing (filter)
import ListUtil exposing (mapN, without)


type alias Coordinate =
    { x : Int, y : Int }


around3x3 : Coordinate -> Difficulty -> List Coordinate
around3x3 center diff =
    let
        x =
            center.x

        y =
            center.y

        xs =
            filter ((<=) 0) (filter ((>) diff.width) [ x - 1, x, x + 1 ])

        ys =
            filter ((<=) 0) (filter ((>) diff.height) [ y - 1, y, y + 1 ])
    in
    without center (mapN Coordinate xs ys)
