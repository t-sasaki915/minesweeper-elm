module ListUtil exposing
    ( contains
    , count
    , exists
    , find
    , forAll
    , listWith
    , listWithout
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
forAll : List Bool -> Bool
forAll boolList =
    forAll (\x -> x) boolList
