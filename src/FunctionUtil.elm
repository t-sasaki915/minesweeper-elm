module FunctionUtil exposing
    ( merge1
    , merge2
    , merge3
    , merge4
    )


merge1 : (a -> b -> c) -> (c -> d) -> a -> b -> d
merge1 f1 f2 a b =
    f2 (f1 a b)


merge2 : (a -> b -> c) -> (a -> b -> d) -> (c -> d -> e) -> a -> b -> e
merge2 f1 f2 f3 a b =
    f3 (f1 a b) (f2 a b)


merge3 : (a -> b) -> (b -> a -> c) -> a -> c
merge3 f1 f2 a =
    f2 (f1 a) a


merge4 : (a -> b -> c) -> (c -> a -> b -> d) -> a -> b -> d
merge4 f1 f2 a b =
    f2 (f1 a b) a b
