module Util exposing ( .. )

import Difficulty exposing ( Difficulty, defaultDifficulty )

difficultyLinkURL : Difficulty -> String
difficultyLinkURL diff =
  if diff == defaultDifficulty then
    "/"
  else
    "/?d=" ++ diff.name
