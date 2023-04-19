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


flagIcon : Html a
flagIcon =
    svg
        [ width "22"
        , height "22"
        ]
        [ rect
            [ x "5"
            , y "15"
            , width "11"
            , height "5"
            ]
            []
        , polygon [ points "5 15, 0 22, 18 22" ] []
        , polygon [ points "16 15, 22 22, 15 22" ] []
        , rect
            [ x "10"
            , y "1"
            , width "1.5"
            , height "16"
            ]
            []
        , polygon [ points "10 1, 10 10, 1 5", fill "red" ] []
        ]
