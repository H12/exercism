module RunLengthEncoding exposing (decode, encode)

import Regex exposing (..)


encode : String -> String
encode string =
    Regex.replace moreThanOne condenser string


decode : String -> String
decode string =
    Regex.replace condensedCharacters expander string


condenser : Regex.Match -> String
condenser match =
    String.fromInt (String.length match.match) ++ String.left 1 match.match


expander : Regex.Match -> String
expander match =
    String.repeat (repeatAmount match.match) (String.right 1 match.match)


repeatAmount : String -> Int
repeatAmount string =
    Maybe.withDefault 0 <|
        String.toInt (String.slice 0 -1 string)


moreThanOne : Regex
moreThanOne =
    Maybe.withDefault Regex.never <|
        Regex.fromString "(.)\\1+"


condensedCharacters : Regex
condensedCharacters =
    Maybe.withDefault Regex.never <|
        Regex.fromString "((\\d)+)[a-zA-Z\\s]"
