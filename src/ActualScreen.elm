module ActualScreen exposing
    ( ActualScreen
    , asActual
    )

import Components
import Html exposing (Html, br, h1, p, text)
import Message exposing (Msg)
import Model exposing (Model)
import Screen exposing (Screen(..))


type alias ActualScreen =
    List (Html Msg)


asActual : Screen -> Model -> ActualScreen
asActual screen model =
    case screen of
        GameScreen ->
            gameScreen model

        UnknownDifficultyScreen ->
            unknownDifficultyScreen model

        WaitingForJSScreen ->
            waitingForJSScreen model

        ErrorScreen ->
            errorScreen model


gameScreen : Model -> ActualScreen
gameScreen model =
    [ Components.gameScreen model
    , br [] []
    , Components.difficultySelector model
    , br [] []
    , Components.aboutPage
    ]


unknownDifficultyScreen : Model -> ActualScreen
unknownDifficultyScreen model =
    [ h1 [] [ text "Unknown Difficulty." ]
    , Components.difficultySelector model
    , br [] []
    , Components.aboutPage
    ]


waitingForJSScreen : Model -> ActualScreen
waitingForJSScreen _ =
    [ p [] [ text "Waiting for JavaScript..." ]
    ]


errorScreen : Model -> ActualScreen
errorScreen _ =
    [ p [] [ text "Something went wrong." ]
    ]
