module Components exposing ( .. )

import Html exposing ( .. )
import Html.Attributes exposing ( .. )

import Difficulty exposing ( Difficulty, allDifficulties )
import Types exposing ( Model )
import Util exposing ( difficultyLinkURL )

difficultyLink : Model -> Difficulty -> Html a
difficultyLink m diff =
  a [ href (difficultyLinkURL m diff) ] [ text diff.displayName, br [] [] ]

difficultySelector : Model -> Html a
difficultySelector m =
  div [] ([span [] [ text "Difficulties:"], br [] [] ] ++ (List.map (difficultyLink m) allDifficulties))

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