module Coordinate exposing (Coordinate, around3x3)

import Difficulty exposing (Difficulty)
import ListUtil


type alias Coordinate =
    { x : Int, y : Int }


around3x3 : Coordinate -> Difficulty -> List Coordinate
around3x3 centre diff =
    let
        x =
            centre.x

        y =
            centre.y

        xs =
            List.filter ((<=) 0) (List.filter ((>) diff.width) [ x - 1, x, x + 1 ])

        ys =
            List.filter ((<=) 0) (List.filter ((>) diff.height) [ y - 1, y, y + 1 ])
    in
    ListUtil.listWithout centre (ListUtil.mapN Coordinate xs ys)
