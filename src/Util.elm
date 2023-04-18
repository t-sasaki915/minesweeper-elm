module Util exposing ( .. )

import Difficulty exposing ( Difficulty, defaultDifficulty )
import Types exposing ( Model )

difficultyLinkURL : Model -> Difficulty -> String
difficultyLinkURL m diff =
  if diff == defaultDifficulty then
    m.path
  else
    m.path ++ "?d=" ++ diff.name
