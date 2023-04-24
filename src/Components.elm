module Components exposing (..)

import Coordinate exposing (Coordinate)
import Difficulty exposing (Difficulty, allDifficulties, defaultDifficulty)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Images exposing (..)
import Message exposing (Msg(..))
import Model exposing (..)
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


cell : Model -> Int -> Int -> Html Msg
cell model x y =
    let
        coord =
            Coordinate x y

        isOpened =
            Model.isCellOpened coord model

        isFlagged =
            Model.isCellFlagged coord model

        isMine =
            Model.isMine coord model

        isCause =
            case model.causeCoord of
                Just c ->
                    coord == c

                Nothing ->
                    False

        isGameOver =
            model.isGameOver

        mineCount =
            Model.mineCountAt coord model

        className =
            if not isGameOver then
                if isOpened then
                    "cell cellOpened"

                else
                    "cell cellNotOpened"

            else if isCause then
                "cell cellCause"

            else if isFlagged && isMine then
                "cell cellNotOpened"

            else if not isFlagged && isMine then
                "cell cellOpened"

            else if isOpened then
                "cell cellOpened"

            else
                "cell cellNotOpened"

        children =
            if shouldRenderFlagIcon coord model then
                [ flagIcon ]

            else if shouldRenderFakeFlagIcon coord model then
                [ fakeFlagIcon ]

            else if shouldRenderWrongFlagIcon coord model then
                [ wrongFlagIcon ]

            else if shouldRenderNumberIcon coord model then
                [ numberIcon mineCount ]

            else if shouldRenderMineIcon coord model then
                [ mineIcon ]

            else
                []
    in
    div [ class className, onClick (CellClick coord) ] children


cellLine : Model -> Int -> Html Msg
cellLine model y =
    div [ class "cellLine" ]
        (List.map (\x -> cell model x y) (List.range 0 (model.difficulty.width - 1)))


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
