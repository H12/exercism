module Etl exposing (transform)

import Dict exposing (Dict)


transform : Dict Int (List String) -> Dict String Int
transform input =
    Dict.toList input
        |> List.concatMap spreadLetters
        |> Dict.fromList


spreadLetters : ( Int, List String ) -> List ( String, Int )
spreadLetters tuple =
    Tuple.second tuple
        |> List.map (setScore (Tuple.first tuple))


setScore : Int -> String -> ( String, Int )
setScore score letter =
    ( String.toLower letter, score )
