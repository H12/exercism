module Hamming exposing (distance)


distance : String -> String -> Result String Int
distance left right =
    if String.length left == String.length right then
        Result.Ok <|
            sumDiff (String.toList left) (String.toList right)

    else
        Result.Err "left and right strands must be of equal length"


sumDiff : List Char -> List Char -> Int
sumDiff left right =
    List.map2 checkDiff left right
        |> List.sum


checkDiff : Char -> Char -> Int
checkDiff left right =
    if left == right then
        0

    else
        1
