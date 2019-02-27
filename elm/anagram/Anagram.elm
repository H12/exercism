module Anagram exposing (detect)


detect : String -> List String -> List String
detect word candidates =
    candidates
        |> List.filter (isAnagram word)


isAnagram : String -> String -> Bool
isAnagram word candidate =
    let
        lowerWord =
            String.toLower word

        lowerCandidate =
            String.toLower candidate
    in
    lowerWord
        /= lowerCandidate
        && sortedCharList lowerWord
        == sortedCharList lowerCandidate


sortedCharList : String -> List Char
sortedCharList string =
    string
        |> String.toList
        |> List.sort
