module Images exposing
    ( fakeFlagIcon
    , flagIcon
    , mineIcon
    , numberIcon
    , wrongFlagIcon
    )

import Html exposing (Html)
import Svg exposing (circle, polygon, rect, svg)
import Svg.Attributes exposing (..)


mineIcon : Html a
mineIcon =
    svg [ width "30", height "30" ]
        [ circle [ cx "15", cy "15", r "11" ] []
        , rect [ x "14", y "0", width "2", height "30" ] []
        , rect [ x "0", y "14", width "30", height "2" ] []
        , polygon [ points "5 6, 6 5, 25 24, 24 25" ] []
        , polygon [ points "25 6, 24 5, 5 24, 6 25" ] []
        ]


flagIcon : Html a
flagIcon =
    svg [ width "22", height "22" ]
        [ polygon [ points "0 22, 5 15, 17 15, 22, 22" ] []
        , rect [ x "10", y "1", width "1.5", height "14" ] []
        , polygon [ points "10 1, 10 10, 1 5", fill "red" ] []
        ]


fakeFlagIcon : Html a
fakeFlagIcon =
    svg [ width "22", height "22" ]
        [ polygon [ points "0 22, 5 15, 17 15, 22, 22", fill "gray" ] []
        , rect [ x "10", y "1", width "1.5", height "14", fill "gray" ] []
        , polygon [ points "10 1, 10 10, 1 5", fill "gray" ] []
        ]


wrongFlagIcon : Html a
wrongFlagIcon =
    svg [ width "22", height "22" ]
        [ polygon [ points "0 22, 5 15, 17 15, 22, 22" ] []
        , rect [ x "10", y "1", width "1.5", height "14" ] []
        , polygon [ points "10 1, 10 10, 1 5", fill "red" ] []
        , polygon [ points "2 0, 0 0, 20 22, 22 22", fill "red" ] []
        , polygon [ points "22 0, 20 0, 0 22, 2 22", fill "red" ] []
        ]


numberIcon : Int -> Html a
numberIcon n =
    svg [ width "30", height "30" ]
        (case n of
            1 ->
                [ rect [ x "13", y "2", width "5", height "21", fill "#0200f9" ] []
                , rect [ x "5", y "23", width "20", height "5", fill "#0200f9" ] []
                , rect [ x "6", y "7", width "7", height "5", fill "#0200f9" ] []
                ]

            2 ->
                [ rect [ x "5", y "2", width "20", height "5", fill "#008001" ] []
                , rect [ x "20", y "7", width "5", height "6", fill "#008001" ] []
                , rect [ x "5", y "13", width "20", height "5", fill "#008001" ] []
                , rect [ x "5", y "18", width "5", height "5", fill "#008001" ] []
                , rect [ x "5", y "23", width "20", height "5", fill "#008001" ] []
                ]

            3 ->
                [ rect [ x "5", y "2", width "20", height "5", fill "#fd0100" ] []
                , rect [ x "20", y "7", width "5", height "6", fill "#fd0100" ] []
                , rect [ x "5", y "13", width "20", height "5", fill "#fd0100" ] []
                , rect [ x "20", y "18", width "5", height "5", fill "#fd0100" ] []
                , rect [ x "5", y "23", width "20", height "5", fill "#fd0100" ] []
                ]

            4 ->
                [ rect [ x "5", y "2", width "5", height "11", fill "#010080" ] []
                , rect [ x "20", y "2", width "5", height "26", fill "#010080" ] []
                , rect [ x "5", y "13", width "15", height "5", fill "#010080" ] []
                ]

            5 ->
                [ rect [ x "5", y "2", width "20", height "5", fill "#800002" ] []
                , rect [ x "5", y "7", width "5", height "6", fill "#800002" ] []
                , rect [ x "5", y "13", width "20", height "5", fill "#800002" ] []
                , rect [ x "20", y "18", width "5", height "5", fill "#800002" ] []
                , rect [ x "5", y "23", width "20", height "5", fill "#800002" ] []
                ]

            6 ->
                [ rect [ x "5", y "2", width "20", height "5", fill "#00817c" ] []
                , rect [ x "5", y "7", width "5", height "16", fill "#00817c" ] []
                , rect [ x "10", y "13", width "15", height "5", fill "#00817c" ] []
                , rect [ x "20", y "18", width "5", height "5", fill "#00817c" ] []
                , rect [ x "5", y "23", width "20", height "5", fill "#00817c" ] []
                ]

            7 ->
                [ rect [ x "5", y "2", width "20", height "5", fill "#000000" ] []
                , rect [ x "5", y "7", width "5", height "6", fill "#000000" ] []
                , rect [ x "20", y "7", width "5", height "21", fill "#000000" ] []
                ]

            8 ->
                [ rect [ x "10", y "2", width "10", height "5", fill "#808080" ] []
                , rect [ x "10", y "13", width "10", height "5", fill "#808080" ] []
                , rect [ x "5", y "2", width "5", height "26", fill "#808080" ] []
                , rect [ x "20", y "2", width "5", height "26", fill "#808080" ] []
                , rect [ x "10", y "23", width "10", height "5", fill "#808080" ] []
                ]

            _ ->
                []
        )
