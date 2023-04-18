module Components exposing (..)

import Difficulty exposing (Difficulty, allDifficulties)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (Model, Msg(..))
import Util exposing (difficultyLinkURL)


difficultyLink : Model -> Difficulty -> Html a
difficultyLink m diff =
    a [ href (difficultyLinkURL m diff) ] [ text diff.displayName, br [] [] ]


difficultySelector : Model -> Html a
difficultySelector m =
    div [] ([ span [] [ text "Difficulties:" ], br [] [] ] ++ List.map (difficultyLink m) allDifficulties)


cell : Model -> Int -> Int -> Html a
cell m x y =
    div [ id ("cell_" ++ String.fromInt x ++ "_" ++ String.fromInt y) ] []


cellLine : Model -> Int -> Difficulty -> Html a
cellLine m y diff =
    div [] (List.map (\x -> cell m x y) (List.range 0 (diff.width - 1)))


cellArray : Model -> Difficulty -> Html a
cellArray m diff =
    div [] (List.map (\y -> cellLine m y diff) (List.range 0 (diff.height - 1)))


toggleFlagPlaceModeButton : Model -> Html Msg
toggleFlagPlaceModeButton m =
    div [ class "btn" ]
        [ span [ class "btnText", onClick ToggleFlagPlaceMode ] [ text "Enter Flag Place Mode" ]
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
