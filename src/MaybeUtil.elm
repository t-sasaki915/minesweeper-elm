module MaybeUtil exposing (getOrElse)


getOrElse : a -> Maybe a -> a
getOrElse default ma =
    case ma of
        Just a ->
            a

        Nothing ->
            default
