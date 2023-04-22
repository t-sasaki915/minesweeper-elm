module Components exposing (..)

import Coordinate exposing (Coordinate)
import Difficulty exposing (Difficulty, allDifficulties, defaultDifficulty)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Images exposing (..)
import Message exposing (Msg(..))
import Model exposing (..)


difficultyLink : Model -> Difficulty -> Html a
difficultyLink m diff =
    let
        linkURL =
            if diff == defaultDifficulty then
                m.path

            else
                m.path ++ "?d=" ++ diff.name
    in
    a [ href linkURL ] [ text diff.displayName, br [] [] ]


difficultySelector : Model -> Html a
difficultySelector m =
    div [] ([ span [] [ text "Difficulties:" ], br [] [] ] ++ List.map (difficultyLink m) allDifficulties)


cell : Model -> Int -> Int -> Html Msg
cell m x y =
    let
        coord =
            Coordinate x y

        inFlagPlaceMode =
            m.inFlagPlaceMode

        isOpened =
            Model.isCellOpened coord m

        isFlagged =
            Model.isCellFlagged coord m

        isMine =
            Model.isMine coord m

        isCause =
            case m.causeCoord of
                Just c ->
                    coord == c

                Nothing ->
                    False

        isGameOver =
            m.isGameOver

        mineCount =
            Model.mineCountAt coord m

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
            if not isGameOver then
                if isOpened then
                    [ numberIcon mineCount ]

                else if isFlagged then
                    [ flagIcon ]

                else if inFlagPlaceMode then
                    [ fakeFlagIcon ]

                else
                    []

            else if isFlagged && isMine then
                [ flagIcon ]

            else if not isFlagged && isMine then
                [ mineIcon ]

            else if isFlagged && not isMine then
                [ wrongFlagIcon ]

            else if isOpened then
                [ numberIcon mineCount ]

            else
                []
    in
    div
        [ class className
        , id ("cell_" ++ String.fromInt x ++ "_" ++ String.fromInt y)
        , onClick (CellClick coord)
        ]
        children


cellLine : Model -> Int -> Difficulty -> Html Msg
cellLine m y diff =
    div [ class "cellLine" ] (List.map (\x -> cell m x y) (List.range 0 (diff.width - 1)))


cellArray : Model -> Difficulty -> Html Msg
cellArray m diff =
    div [ class "cellArray" ] (List.map (\y -> cellLine m y diff) (List.range 0 (diff.height - 1)))


toggleFlagPlaceModeButton : Model -> Html Msg
toggleFlagPlaceModeButton m =
    let
        buttonText =
            if m.inFlagPlaceMode then
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


gameScreen : Model -> Difficulty -> Html Msg
gameScreen m diff =
    div []
        [ cellArray m diff
        , br [] []
        , toggleFlagPlaceModeButton m
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
