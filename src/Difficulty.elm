module Difficulty exposing (..)

type Difficulty = Difficulty String String Int Int Int

easy : Difficulty
easy = Difficulty "easy" "Easy" 9 9 10

normal : Difficulty
normal = Difficulty "normal" "Normal" 16 16 40

hard : Difficulty
hard = Difficulty "hard" "Hard" 30 16 99

impossible : Difficulty
impossible = Difficulty "impossible" "Impossible" 9 9 67
