module WordCount exposing (wordCount)

import Dict exposing (Dict)
import Regex exposing (Regex)


wordCount : String -> Dict String Int
wordCount sentence =
    sentence
        |> removePunctuation
        |> String.toLower
        |> String.words
        |> countWords


removePunctuation : String -> String
removePunctuation sentence =
    Regex.replace nonLetters (\_ -> "") sentence


nonLetters : Regex
nonLetters =
    Regex.fromString "[^\\w\\s]"
        |> Maybe.withDefault Regex.never


countWords : List String -> Dict String Int
countWords words =
    List.foldl reduceCount Dict.empty words


reduceCount : String -> Dict String Int -> Dict String Int
reduceCount word counts =
    Dict.update word (increment) counts


increment : Maybe Int -> Maybe Int
increment count =
    Just (Maybe.withDefault 0 count + 1)
