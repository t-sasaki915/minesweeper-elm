module ActualComponent exposing
    ( ActualComponent
    , asActual
    )

import Component exposing (Component(..))
import Difficulty exposing (allDifficulties, defaultDifficulty)
import Html exposing (Html, a, br, div, span, text)
import Html.Attributes exposing (href)
import List exposing (map)
import Message exposing (Msg)
import Model exposing (Model)


type alias ActualComponent =
    Html Msg


asActual : Component -> Model -> ActualComponent
asActual component model =
    case component of
        GameContainer ->
            gameContainer model

        DifficultySelector ->
            difficultySelector model

        AboutPage ->
            aboutPage model


gameContainer : Model -> ActualComponent
gameContainer model =
    div [] []


difficultySelector : Model -> ActualComponent
difficultySelector model =
    let
        diffLink diff =
            if diff == defaultDifficulty then
                model.path

            else
                model.path ++ "?d=" ++ diff.name

        diffAnchor diff =
            a [ href (diffLink diff) ] [ text diff.displayName ]
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
