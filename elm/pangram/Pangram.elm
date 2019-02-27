module Pangram exposing (isPangram)


isPangram : String -> Bool
isPangram sentence =
    sentence
        |> String.toLower
        |> containsAll alphabet


containsAll : List String -> String -> Bool
containsAll list string =
    List.all (\char -> String.contains char string) list


alphabet : List String
alphabet =
    [ "a"
    , "b"
    , "c"
    , "d"
    , "e"
    , "f"
    , "g"
    , "h"
    , "i"
    , "j"
    , "k"
    , "l"
    , "m"
    , "n"
    , "o"
    , "p"
    , "q"
    , "r"
    , "s"
    , "t"
    , "u"
    , "v"
    , "w"
    , "x"
    , "y"
    , "z"
    ]
