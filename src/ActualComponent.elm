module ActualComponent exposing
    ( ActualComponent
    , actualizeComponent
    )

import ActualCell exposing (actualizeCellClass, actualizeCellIcon)
import Cell exposing (cellClassAt, cellIconAt)
import Component exposing (Component(..))
import Coordinate exposing (Coordinate)
import Difficulty exposing (allDifficulties, defaultDifficulty)
import FunctionUtil exposing (merge3, merge4)
import Html exposing (Html, a, br, div, h1, p, span, text)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import List exposing (length, map, range)
import Message exposing (Msg(..))
import Model exposing (Model)
import TimeUtil exposing (posixDelta, posixToSeconds)


type alias ActualComponent =
    Html Msg


actualizeComponent : Component -> Model -> ActualComponent
actualizeComponent component model =
    case component of
        GameContainer ->
            gameContainer model

        UnknownDifficultyText ->
            unknownDifficultyText model

        DifficultySelector ->
            difficultySelector model

        AboutPage ->
            aboutPage model

        WaitingForJSText ->
            waitingForJSText model

        SomethingWentWrongText ->
            somethingWentWrongText model

        NewLine ->
            newLine model


gameContainer : Model -> ActualComponent
gameContainer model =
    div []
        [ cellArray model
        , statusIndicator model
        , toggleFlagPlaceModeButton model
        , toggleChordModeButton model
        , restartButton model
        ]


cellArray : Model -> ActualComponent
cellArray model =
    let
        cell coord =
            div
                [ class (merge3 (cellClassAt coord) actualizeCellClass model)
                , onClick (CellClick coord)
                ]
                (merge4 cellIconAt actualizeCellIcon coord model)

        cellLine y =
            div [ class "cellLine" ]
                (map
                    (\x -> cell (Coordinate x y))
                    (range 0 (model.difficulty.width - 1))
                )
    in
    div [ class "cellArray" ]
        (map cellLine (range 0 (model.difficulty.height - 1)))


statusIndicator : Model -> ActualComponent
statusIndicator model =
    let
        elapsedTime =
            if model.isGameStarted then
                posixToSeconds
                    (if model.isGameOver then
                        posixDelta model.startTime model.gameOverTime

                     else
                        posixDelta model.startTime model.currentTime
                    )

            else
                0

        mineRemains =
            model.difficulty.mineCount - length model.flaggedCoords
    in
    p []
        [ text "Elapsed Time: "
        , text (String.fromInt elapsedTime)
        , text "s, Mine Remains: "
        , text (String.fromInt mineRemains)
        ]


toggleFlagPlaceModeButton : Model -> ActualComponent
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


toggleChordModeButton : Model -> ActualComponent
toggleChordModeButton model =
    let
        buttonText =
            if model.inChordMode then
                "Exit Chord Mode"

            else
                "Enter Chord Mode"
    in
    div [ class "btn" ]
        [ span [ class "btnText" ] [ text buttonText ]
        ]


restartButton : Model -> ActualComponent
restartButton _ =
    div [ class "btn" ]
        [ span [ class "btnText", onClick RestartGame ] [ text "Restart" ]
        ]


unknownDifficultyText : Model -> ActualComponent
unknownDifficultyText _ =
    h1 [] [ text "Unknown Difficulty." ]


difficultySelector : Model -> ActualComponent
difficultySelector model =
    let
        diffLink diff =
            if diff == defaultDifficulty then
                model.path

            else
                model.path ++ "?d=" ++ diff.name

        diffAnchor diff =
            a [ href (diffLink diff) ] [ text diff.displayName, br [] [] ]
    in
    div []
        ([ span [] [ text "Difficulties:" ]
         , br [] []
         ]
            ++ map diffAnchor allDifficulties
        )


aboutPage : Model -> ActualComponent
aboutPage _ =
    div []
        [ span [] [ text "This site is licensed under the " ]
        , a [ href "https://github.com/t-sasaki915/minesweeper-elm/blob/main/LICENSE" ] [ text "MIT License" ]
        , span [] [ text "." ]
        , br [] []
        , span [] [ text "This is site open source. " ]
        , a [ href "https://github.com/t-sasaki915/minesweeper-elm" ] [ text "Improve this site" ]
        , br [] []
        , span [] [ text "Powered by " ]
        , a [ href "https://pages.github.com" ] [ text "GitHub Pages" ]
        , span [] [ text "." ]
        ]


waitingForJSText : Model -> ActualComponent
waitingForJSText _ =
    p [] [ text "Waiting for JavaScript..." ]


somethingWentWrongText : Model -> ActualComponent
somethingWentWrongText _ =
    p [] [ text "Something went wrong." ]


newLine : Model -> ActualComponent
newLine _ =
    br [] []
