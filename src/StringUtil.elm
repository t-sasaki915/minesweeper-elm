module StringUtil exposing
    ( firstIndexOf
    , takeAfter
    , takeBefore
    , takeLeft
    , takeRight
    )

import String exposing (dropLeft, dropRight, length, startsWith)


takeLeft : Int -> String -> String
takeLeft n str =
    dropRight (length str - n) str


takeRight : Int -> String -> String
takeRight n str =
    dropLeft (length str - n) str


firstIndexOf : String -> String -> Maybe Int
firstIndexOf search str =
    let
        tailrec index =
            if length str <= index then
                Nothing

            else if startsWith search (dropLeft index str) then
                Just index

            else
                tailrec (index + 1)
    in
    tailrec 0


takeBefore : String -> String -> String
takeBefore search str =
    case firstIndexOf search str of
        Just firstIndex ->
            takeLeft firstIndex str

        Nothing ->
            ""


takeAfter : String -> String -> String
takeAfter search str =
    case firstIndexOf search str of
        Just firstIndex ->
            takeRight firstIndex str

        Nothing ->
            ""
