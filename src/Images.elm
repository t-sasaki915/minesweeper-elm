module Images exposing (..)

import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)


mineIcon : Html a
mineIcon =
    svg
        [ width "30"
        , height "30"
        ]
        [ circle
            [ cx "15"
            , cy "15"
            , r "11"
            , stroke "black"
            , fill "black"
            ]
            []
        , rect
            [ x "14"
            , y "0"
            , width "2"
            , height "30"
            ]
            []
        , rect
            [ x "0"
            , y "14"
            , width "30"
            , height "2"
            ]
            []
        , rect
            [ x "20"
            , y "-14"
            , width "1.5"
            , height "28"
            , transform "rotate(45)"
            ]
            []
        , rect
            [ x "7"
            , y "0"
            , width "28"
            , height "1.5"
            , transform "rotate(45)"
            ]
            []
        ]
