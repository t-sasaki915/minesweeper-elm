module Images exposing (..)

import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)


mineIcon : Html a
mineIcon =
    svg [ width "30", height "30" ]
        [ circle [ cx "15", cy "15", r "11" ] []
        , rect [ x "14", y "0", width "2", height "30" ] []
        , rect [ x "0", y "14", width "30", height "2" ] []
        , rect [ x "20", y "-14", width "1.5", height "28", transform "rotate(45)" ] []
        , rect [ x "7", y "0", width "28", height "1.5", transform "rotate(45)" ] []
        ]


flagIcon : Html a
flagIcon =
    svg [ width "22", height "22" ]
        [ rect [ x "5", y "15", width "11", height "5" ] []
        , polygon [ points "5 15, 0 22, 20 22" ] []
        , polygon [ points "16 15, 22 22, 15 22" ] []
        , rect [ x "10", y "1", width "1.5", height "16" ] []
        , polygon [ points "10 1, 10 10, 1 5", fill "red" ] []
        ]


fakeFlagIcon : Html a
fakeFlagIcon =
    svg [ width "22", height "22" ]
        [ rect [ x "5", y "15", width "11", height "5", fill "gray" ] []
        , polygon [ points "5 15, 0 22, 20 22", fill "gray" ] []
        , polygon [ points "16 15, 22 22, 15 22", fill "gray" ] []
        , rect [ x "10", y "1", width "1.5", height "16", fill "gray" ] []
        , polygon [ points "10 1, 10 10, 1 5", fill "gray" ] []
        ]


wrongFlagIcon : Html a
wrongFlagIcon =
    svg [ width "22", height "22" ]
        [ rect [ x "5", y "15", width "11", height "5" ] []
        , polygon [ points "5 15, 0 22, 20 22" ] []
        , polygon [ points "16 15, 22 22, 15 22" ] []
        , rect [ x "10", y "1", width "1.5", height "16" ] []
        , polygon [ points "10 1, 10 10, 1 5", fill "red" ] []
        , polygon [ points "2 0, 0 0, 20 22, 22 22", fill "red" ] []
        , polygon [ points "22 0, 20 0, 0 22, 2 22", fill "red" ] []
        ]


numberIcon : Int -> Html a
numberIcon n =
    svg [ width "30", height "30" ]
        (case n of
            1 ->
                [ rect [ x "13", y "0", width "5", height "25", fill "#0200f9" ] []
                , rect [ x "5", y "23", width "20", height "5", fill "#0200f9" ] []
                , rect [ x "6", y "5", width "7", height "5", fill "#0200f9" ] []
                ]

            2 ->
                [ rect [ x "5", y "0", width "20", height "5", fill "#008001" ] []
                , rect [ x "20", y "0", width "5", height "15", fill "#008001" ] []
                , rect [ x "5", y "11", width "20", height "5", fill "#008001" ] []
                , rect [ x "5", y "11", width "5", height "15", fill "#008001" ] []
                , rect [ x "5", y "23", width "20", height "5", fill "#008001" ] []
                ]

            3 ->
                [ rect [ x "5", y "0", width "20", height "5", fill "#fd0100" ] []
                , rect [ x "20", y "0", width "5", height "15", fill "#fd0100" ] []
                , rect [ x "5", y "11", width "20", height "5", fill "#fd0100" ] []
                , rect [ x "20", y "11", width "5", height "15", fill "#fd0100" ] []
                , rect [ x "5", y "23", width "20", height "5", fill "#fd0100" ] []
                ]

            4 ->
                [ rect [ x "5", y "0", width "5", height "11", fill "#010080" ] []
                , rect [ x "20", y "0", width "5", height "15", fill "#010080" ] []
                , rect [ x "5", y "11", width "20", height "5", fill "#010080" ] []
                , rect [ x "20", y "11", width "5", height "15", fill "#010080" ] []
                , rect [ x "20", y "23", width "5", height "5", fill "#010080" ] []
                ]

            5 ->
                [ rect [ x "5", y "0", width "20", height "5", fill "#800002" ] []
                , rect [ x "5", y "0", width "5", height "15", fill "#800002" ] []
                , rect [ x "5", y "11", width "20", height "5", fill "#800002" ] []
                , rect [ x "20", y "11", width "5", height "15", fill "#800002" ] []
                , rect [ x "5", y "23", width "20", height "5", fill "#800002" ] []
                ]

            6 ->
                [ rect [ x "5", y "0", width "20", height "5", fill "#00817c" ] []
                , rect [ x "5", y "0", width "5", height "15", fill "#00817c" ] []
                , rect [ x "5", y "11", width "20", height "5", fill "#00817c" ] []
                , rect [ x "20", y "11", width "5", height "15", fill "#00817c" ] []
                , rect [ x "5", y "11", width "5", height "15", fill "#00817c" ] []
                , rect [ x "5", y "23", width "20", height "5", fill "#00817c" ] []
                ]

            7 ->
                [ rect [ x "5", y "0", width "20", height "5", fill "#000000" ] []
                , rect [ x "5", y "0", width "5", height "13", fill "#000000" ] []
                , rect [ x "20", y "0", width "5", height "15", fill "#000000" ] []
                , rect [ x "20", y "11", width "5", height "15", fill "#000000" ] []
                , rect [ x "20", y "23", width "5", height "5", fill "#000000" ] []
                ]

            8 ->
                [ rect [ x "5", y "0", width "20", height "5", fill "#808080" ] []
                , rect [ x "5", y "0", width "5", height "15", fill "#808080" ] []
                , rect [ x "20", y "0", width "5", height "15", fill "#808080" ] []
                , rect [ x "5", y "11", width "20", height "5", fill "#808080" ] []
                , rect [ x "5", y "11", width "5", height "15", fill "#808080" ] []
                , rect [ x "20", y "11", width "5", height "15", fill "#808080" ] []
                , rect [ x "5", y "23", width "20", height "5", fill "#808080" ] []
                ]

            _ ->
                []
        )
