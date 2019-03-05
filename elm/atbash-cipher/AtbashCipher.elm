module AtbashCipher exposing (decode, encode)

import Dict exposing (..)


encode : String -> String
encode plain =
    plain
        |> String.toLower
        |> String.replace " " ""
        |> String.map (mapChar cipherMap)


decode : String -> String
decode cipher =
    Debug.todo "Please implement this function"


mapChar : Dict Char Char -> Char -> Char
mapChar charMap key =
    Maybe.withDefault 'a' <| Dict.get key charMap


cipherMap : Dict Char Char
cipherMap =
    Dict.fromList
        [ ( 'a', 'z' )
        , ( 'b', 'y' )
        , ( 'c', 'x' )
        , ( 'd', 'w' )
        , ( 'e', 'v' )
        , ( 'f', 'u' )
        , ( 'g', 't' )
        , ( 'h', 's' )
        , ( 'i', 'r' )
        , ( 'j', 'q' )
        , ( 'k', 'p' )
        , ( 'l', 'o' )
        , ( 'm', 'n' )
        , ( 'n', 'm' )
        , ( 'o', 'l' )
        , ( 'p', 'k' )
        , ( 'q', 'j' )
        , ( 'r', 'i' )
        , ( 's', 'h' )
        , ( 't', 'g' )
        , ( 'u', 'f' )
        , ( 'v', 'e' )
        , ( 'w', 'd' )
        , ( 'x', 'c' )
        , ( 'y', 'b' )
        , ( 'z', 'a' )
        ]
