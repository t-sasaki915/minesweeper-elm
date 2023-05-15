module Screen exposing
    ( Screen(..)
    , currentScreen
    )

import ListUtil exposing (contains, forAll)
import Model exposing (Model)


type Screen
    = GameScreen
    | UnknownDifficultyScreen
    | WaitingForJSScreen
    | ErrorScreen


currentScreen : Model -> Screen
currentScreen model =
    if shouldRenderGameScreen model then
        GameScreen

    else if shouldRenderUnknownDifficultyScreen model then
        UnknownDifficultyScreen

    else if shouldRenderWaitingForJSScreen model then
        WaitingForJSScreen

    else
        ErrorScreen


identityForAll : List Bool -> Bool
identityForAll =
    forAll identity


containsTrue : List Bool -> Bool
containsTrue =
    contains True


shouldRenderGameScreen : Model -> Bool
shouldRenderGameScreen model =
    identityForAll
        [ model.difficultyReceived
        , model.pathReceived
        , not model.unknownDifficulty
        ]


shouldRenderUnknownDifficultyScreen : Model -> Bool
shouldRenderUnknownDifficultyScreen model =
    identityForAll
        [ model.difficultyReceived
        , model.pathReceived
        , model.unknownDifficulty
        ]


shouldRenderWaitingForJSScreen : Model -> Bool
shouldRenderWaitingForJSScreen model =
    containsTrue
        [ not model.difficultyReceived
        , not model.pathReceived
        ]
