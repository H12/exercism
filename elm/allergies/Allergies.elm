module Allergies exposing (isAllergicTo, toList)

import Bitwise exposing (..)
import Dict exposing (..)


isAllergicTo : String -> Int -> Bool
isAllergicTo name score =
    let
        allergyValue =
            Dict.get name allergies
                |> Maybe.withDefault 0
    in
    not (Bitwise.and score allergyValue == 0)


toList : Int -> List String
toList score =
    allergies
        |> Dict.keys
        |> List.filter (\name -> isAllergicTo name score)


allergies : Dict String Int
allergies =
    Dict.fromList
        [ ( "eggs", 1 )
        , ( "peanuts", 2 )
        , ( "shellfish", 4 )
        , ( "strawberries", 8 )
        , ( "tomatoes", 16 )
        , ( "chocolate", 32 )
        , ( "pollen", 64 )
        , ( "cats", 128 )
        ]
