module SumOfMultiples exposing (sumOfMultiples)


sumOfMultiples : List Int -> Int -> Int
sumOfMultiples multiples limit =
    List.sum <| getMultiples multiples limit


getMultiples : List Int -> Int -> List Int
getMultiples multiples limit =
    List.filter (isDivisibleBy multiples) (List.range 1 (limit - 1))


isDivisibleBy : List Int -> Int -> Bool
isDivisibleBy multiples multiple =
    List.any (\m -> modBy m multiple == 0) multiples
