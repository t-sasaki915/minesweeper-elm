module StringUtil exposing
    ( firstIndexOf
    , takeAfter
    , takeBefore
    , takeLeft
    , takeRight
    )


takeLeft : Int -> String -> String
takeLeft n str =
    String.dropRight (String.length str - n) str


takeRight : Int -> String -> String
takeRight n str =
    String.dropLeft (String.length str - n) str


firstIndexOf_ : String -> String -> Int -> Maybe Int
firstIndexOf_ search str index =
    if String.length str <= index then
        Nothing

    else if String.startsWith search (String.dropLeft index str) then
        Just index

    else
        firstIndexOf_ search str (index + 1)


firstIndexOf : String -> String -> Maybe Int
firstIndexOf search str =
    firstIndexOf_ search str 0


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
            String.dropLeft (firstIndex + String.length search) str

        Nothing ->
            ""
