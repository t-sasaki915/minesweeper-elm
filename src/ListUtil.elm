module ListUtil exposing
    ( contains
    , count
    , exists
    , find
    , flatten
    , forAll
    , mapN
    , nonEmpty
    , notContains
    , numberOf
    , without
    )


merge : (a -> b -> c) -> (c -> d) -> a -> b -> d
merge f1 f2 a b =
    f2 (f1 a b)


nonEmpty : List a -> Bool
nonEmpty list =
    not (List.isEmpty list)


exists : (a -> Bool) -> List a -> Bool
exists func list =
    nonEmpty (List.filter func list)


contains : a -> List a -> Bool
contains a list =
    exists (\x -> x == a) list


notContains : a -> List a -> Bool
notContains =
    merge contains not


without : a -> List a -> List a
without a list =
    List.filter (\x -> not (x == a)) list


count : (a -> Bool) -> List a -> Int
count func list =
    List.length (List.filter func list)


numberOf : a -> List a -> Int
numberOf a list =
    count (\x -> x == a) list


find : (a -> Bool) -> List a -> Maybe a
find func list =
    List.head (List.filter func list)


forAll : (a -> Bool) -> List a -> Bool
forAll func list =
    numberOf False (List.map func list) == 0


flatten : List (List a) -> List a
flatten list =
    List.foldl List.append [] list


mapN : (a -> b -> c) -> List a -> List b -> List c
mapN f l1 l2 =
    flatten
        (List.map
            (\a ->
                List.map
                    (\b ->
                        f a b
                    )
                    l2
            )
            l1
        )
