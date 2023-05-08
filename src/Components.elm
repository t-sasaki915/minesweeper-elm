module Components exposing
    ( aboutPage
    , difficultySelector
    , gameScreen
    )

import Coordinate exposing (Coordinate)
import Difficulty exposing (Difficulty, allDifficulties, defaultDifficulty)
import GameLogic exposing (calcMineCountAt)
import Html exposing (Html, a, br, div, span, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Images exposing (..)
import Message exposing (Msg(..))
import Model exposing (Model)
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
            if shouldClassNameBeCellOpened coord model then
                "cell cellOpened"

            else if shouldClassNameBeCellNotOpened coord model then
                "cell cellNotOpened"

            else if shouldClassNameBeCellCause coord model then
                "cell cellCause"

            else
                "cell"

        children =
            if shouldRenderFlagIcon coord model then
                [ flagIcon ]

            else if shouldRenderFakeFlagIcon coord model then
                [ fakeFlagIcon ]

            else if shouldRenderWrongFlagIcon coord model then
                [ wrongFlagIcon ]

            else if shouldRenderNumberIcon coord model then
                [ numberIcon (calcMineCountAt coord model) ]

            else if shouldRenderMineIcon coord model then
                [ mineIcon ]

            else
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
        , br [] []
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
