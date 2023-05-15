module ActualScreen exposing
    ( ActualScreen
    , actualizeScreen
    )

import ActualComponent exposing (actualizeComponent)
import Component exposing (Component(..))
import Html exposing (Html)
import List exposing (map)
import Message exposing (Msg)
import Model exposing (Model)
import Screen exposing (Screen(..))


type alias ActualScreen =
    List (Html Msg)


actualizeScreen : Screen -> Model -> ActualScreen
actualizeScreen screen model =
    case screen of
        GameScreen ->
            gameScreen model

        UnknownDifficultyScreen ->
            unknownDifficultyScreen model

        WaitingForJSScreen ->
            waitingForJSScreen model

        ErrorScreen ->
            errorScreen model


actualize : List Component -> Model -> ActualScreen
actualize components model =
    map (\c -> actualizeComponent c model) components


gameScreen : Model -> ActualScreen
gameScreen =
    actualize
        [ GameContainer
        , NewLine
        , DifficultySelector
        , NewLine
        , AboutPage
        ]


unknownDifficultyScreen : Model -> ActualScreen
unknownDifficultyScreen =
    actualize
        [ UnknownDifficultyText
        , DifficultySelector
        , NewLine
        , AboutPage
        ]


waitingForJSScreen : Model -> ActualScreen
waitingForJSScreen =
    actualize
        [ WaitingForJSText
        ]


errorScreen : Model -> ActualScreen
errorScreen =
    actualize
        [ SomethingWentWrongText
        ]
