module Util exposing ( .. )

import Difficulty exposing ( Difficulty, defaultDifficulty )
import Types exposing ( Model )

difficultyLinkURL : Model -> Difficulty -> String
difficultyLinkURL m diff =
  let baseURL = case m.path of
                  "/"   -> "/"
                  other -> "/" ++ other ++ "/"
  in
  if diff == defaultDifficulty then
    baseURL
  else
    baseURL ++ "?d=" ++ diff.name
