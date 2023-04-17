module Components exposing ( .. )

import Html exposing ( .. )
import Html.Attributes exposing ( .. )

import Difficulty exposing ( Difficulty, allDifficulties )
import Util exposing ( difficultyLinkURL )

difficultyLink : Difficulty -> Html a
difficultyLink diff = a [ href (difficultyLinkURL diff) ] [ text diff.displayName, br [] [] ]

difficultySelector : Html a
difficultySelector =
  div [] ([span [] [ text "Difficulties:"], br [] [] ] ++ (List.map difficultyLink allDifficulties))

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