module Components exposing (..)

import Conditions exposing (..)
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
            if shouldRenderFlagIcon coord m then
                [ flagIcon ]

            else if shouldRenderFakeFlagIcon coord m then
                [ fakeFlagIcon ]

            else if shouldRenderWrongFlagIcon coord m then
                [ wrongFlagIcon ]

            else if shouldRenderNumberIcon coord m then
                [ numberIcon mineCount ]

            else if shouldRenderMineIcon coord m then
                [ mineIcon ]

            else
                []
    in
    div
        [ class className
        , id ("cell_" ++ String.fromInt x ++ "_" ++ String.fromInt y)
        , onClick (CellClick coord)
        ]
        children


cellLine : Model -> Int -> Html Msg
cellLine m y =
    let
        diff =
            m.difficulty
    in
    div [ class "cellLine" ] (List.map (\x -> cell m x y) (List.range 0 (diff.width - 1)))


cellArray : Model -> Html Msg
cellArray m =
    let
        diff =
            m.difficulty
    in
    div [ class "cellArray" ] (List.map (\y -> cellLine m y) (List.range 0 (diff.height - 1)))


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
