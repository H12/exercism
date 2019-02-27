module Bob exposing (hey)
import Regex

hey : String -> String
hey remark =
    if isSilence remark then
        "Fine. Be that way!"
    else if isQuestion remark && isShout remark then
        "Calm down, I know what I'm doing!"
    else if isShout remark then
        "Whoa, chill out!"
    else if isQuestion remark then
        "Sure."
    else
        "Whatever."


isQuestion : String -> Bool
isQuestion remark =
    String.right 1 remark == "?"


isSilence : String -> Bool
isSilence remark =
    (String.trim remark |> String.length) == 0


isShout : String -> Bool
isShout remark =
    hasUppercaseLetters remark && not (hasLowercaseLetters remark)


hasLowercaseLetters : String -> Bool
hasLowercaseLetters string =
    Regex.contains lowerCase string


hasUppercaseLetters : String -> Bool
hasUppercaseLetters string =
    Regex.contains upperCase string


lowerCase : Regex.Regex
lowerCase =
    Maybe.withDefault Regex.never <|
        Regex.fromString "[a-z]+"

upperCase : Regex.Regex
upperCase =
    Maybe.withDefault Regex.never <|
        Regex.fromString "[A-Z]+"
