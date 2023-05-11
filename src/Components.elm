module Components exposing
    ( aboutPage
    , difficultySelector
    , gameScreen
    )

import Clock exposing (millisToSeconds)
import Coordinate exposing (Coordinate)
import Difficulty exposing (Difficulty, allDifficulties, defaultDifficulty)
import GameLogic exposing (calcMineCountAt)
import Html exposing (Html, a, br, div, p, span, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Images exposing (..)
import Message exposing (Msg(..))
import Model exposing (Model)
import Time exposing (posixToMillis)
import UIConditions exposing (..)


difficultyLink : Model -> Difficulty -> Html a
difficultyLink model diff =
    let
        linkURL =
            if diff == defaultDifficulty then
                model.path

            else
                model.path ++ "?d=" ++ diff.name
    in
    a [ href linkURL ] [ text diff.displayName, br [] [] ]


difficultySelector : Model -> Html a
difficultySelector model =
    div []
        ([ span [] [ text "Difficulties:" ], br [] [] ]
            ++ List.map (difficultyLink model) allDifficulties
        )


cell : Model -> Coordinate -> Html Msg
cell model coord =
    let
        className =
            case cellClassAt coord model of
                CellOpened ->
                    "cell cellOpened"

                CellNotOpened ->
                    "cell cellNotOpened"

                CellCause ->
                    "cell cellCause"

                NoClass ->
                    "cell"

        children =
            case innerIconAt coord model of
                FlagIcon ->
                    [ flagIcon ]

                FakeFlagIcon ->
                    [ fakeFlagIcon ]

                WrongFlagIcon ->
                    [ wrongFlagIcon ]

                NumberIcon ->
                    [ numberIcon (calcMineCountAt coord model) ]

                MineIcon ->
                    [ mineIcon ]

                NoIcon ->
                    []
    in
    div [ class className, onClick (CellClick coord) ] children


cellLine : Model -> Int -> Html Msg
cellLine model y =
    div [ class "cellLine" ]
        (List.map (\x -> cell model (Coordinate x y)) (List.range 0 (model.difficulty.width - 1)))


cellArray : Model -> Html Msg
cellArray model =
    div [ class "cellArray" ]
        (List.map (\y -> cellLine model y) (List.range 0 (model.difficulty.height - 1)))


statusIndicator : Model -> Html Msg
statusIndicator model =
    let
        elapsedMillis =
            if model.isGameStarted then
                if model.isGameOver then
                    posixToMillis model.gameOverTime - posixToMillis model.startTime

                else
                    posixToMillis model.currentTime - posixToMillis model.startTime

            else
                0

        elapsedTime =
            millisToSeconds elapsedMillis

        mineRemains =
            model.difficulty.mineCount - List.length model.flaggedCoords
    in
    p []
        [ text "Elapsed Time: "
        , text (String.fromInt elapsedTime)
        , text "s, Mine Remains: "
        , text (String.fromInt mineRemains)
        ]


toggleFlagPlaceModeButton : Model -> Html Msg
toggleFlagPlaceModeButton model =
    let
        buttonText =
            if model.inFlagPlaceMode then
                "Exit Flag Place Mode"

            else
                "Enter Flag Place Mode"
    in
    div [ class "btn" ]
        [ span [ class "btnText", onClick ToggleFlagPlaceMode ] [ text buttonText ]
        ]


restartButton : Html Msg
restartButton =
    div [ class "btn" ]
        [ span [ class "btnText", onClick RestartGame ] [ text "Restart" ]
        ]


gameScreen : Model -> Html Msg
gameScreen model =
    div []
        [ cellArray model
        , statusIndicator model
        , toggleFlagPlaceModeButton model
        , br [] []
        , restartButton
        ]


aboutPage : Html a
aboutPage =
    div []
        [ span [] [ text "This site is licensed under the " ]
        , a [ href "https://github.com/t-sasaki915/minesweeper-elm/blob/main/LICENSE" ] [ text "MIT License" ]
        , span [] [ text "." ]
        , br [] []
        , span [] [ text "This site is open source. " ]
        , a [ href "https://github.com/t-sasaki915/minesweeper-elm" ] [ text "Improve this site" ]
        , br [] []
        , span [] [ text "Powered by " ]
        , a [ href "https://pages.github.com" ] [ text "GitHub Pages" ]
        , span [] [ text "." ]
        ]
