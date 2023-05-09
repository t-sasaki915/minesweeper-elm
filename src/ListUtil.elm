module ListUtil exposing
    ( contains
    , count
    , exists
    , find
    , flatten
    , forAll
    , listWith
    , listWithout
    , mapN
    , nonEmpty
    , numberOf
    )


nonEmpty : List a -> Bool
nonEmpty list =
    not (List.isEmpty list)


exists : (a -> Bool) -> List a -> Bool
exists func list =
    nonEmpty (List.filter func list)


contains : a -> List a -> Bool
contains a list =
    exists (\x -> x == a) list


listWith : a -> List a -> List a
listWith a list =
    a :: list


listWithout : a -> List a -> List a
listWithout a list =
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
