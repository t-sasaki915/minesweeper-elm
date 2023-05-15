module Difficulty exposing
    ( Difficulty
    , allDifficulties
    , defaultDifficulty
    , fromString
    )

import ListUtil exposing (find)


type alias Difficulty =
    { name : String
    , displayName : String
    , width : Int
    , height : Int
    , mineCount : Int
    }


easy : Difficulty
easy =
    Difficulty "easy" "Easy" 9 9 10


normal : Difficulty
normal =
    Difficulty "normal" "Normal" 16 16 40


hard : Difficulty
hard =
    Difficulty "hard" "Hard" 30 16 99


impossible : Difficulty
impossible =
    Difficulty "impossible" "Impossible" 9 9 67


defaultDifficulty : Difficulty
defaultDifficulty =
    easy


allDifficulties : List Difficulty
allDifficulties =
    [ easy
    , normal
    , hard
    , impossible
    ]


fromString : String -> Maybe Difficulty
fromString str =
    case str of
        "" ->
            Just defaultDifficulty

        other ->
            find (\x -> x.name == other) allDifficulties
