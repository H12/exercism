module Luhn exposing (valid)


valid : String -> Bool
valid input =
    let
        condensedInput =
            String.replace " " "" input
    in
    if validInput condensedInput then
        False

    else
        condensedInput
            |> String.split ""
            |> List.filterMap String.toInt
            |> List.reverse
            |> List.indexedMap indexedLuhnDouble
            |> List.sum
            |> (\sum -> modBy 10 sum == 0)


validInput : String -> Bool
validInput input =
    String.length input <= 1 || String.any (not << Char.isDigit) input


indexedLuhnDouble : Int -> Int -> Int
indexedLuhnDouble index number =
    if modBy 2 index == 1 then
        luhnDouble number

    else
        number


luhnDouble : Int -> Int
luhnDouble number =
    let
        doubledNumber =
            number * 2
    in
    if doubledNumber > 9 then
        doubledNumber - 9

    else
        doubledNumber
