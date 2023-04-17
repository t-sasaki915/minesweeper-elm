module Components exposing ( .. )

import Html exposing ( .. )
import Html.Attributes exposing ( .. )

import Difficulty exposing ( Difficulty, allDifficulties )

difficultyLink : Difficulty -> Html a
difficultyLink diff = a [href ("/?d=" ++ diff.name) ] [ text diff.displayName, br [] [] ]

difficultySelector : Html a
difficultySelector =
  div [] ([span [] [ text "Difficulties:"], br [] []] ++ (List.map difficultyLink allDifficulties))