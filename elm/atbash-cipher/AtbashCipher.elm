module AtbashCipher exposing (decode, encode)

import Dict exposing (..)
import Regex exposing (..)


encode : String -> String
encode plain =
    plain
        |> String.toLower
        |> Regex.replace nonWordCharacter (\_ -> "")
        |> String.map mapLetter
        |> splitEvery 5
        |> String.join " "


decode : String -> String
decode cipher =
    cipher
        |> String.replace " " ""
        |> String.map mapLetter


nonWordCharacter : Regex
nonWordCharacter =
    Maybe.withDefault Regex.never <|
        Regex.fromString "\\W"


splitEvery : Int -> String -> List String
splitEvery n input =
    case input of
        "" ->
            []

        _ ->
            [ String.left n input ] ++ splitEvery n (String.dropLeft n input)


mapLetter : Char -> Char
mapLetter key =
    Maybe.withDefault key <|
        Dict.get key cipherMap


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
