module CollatzConjecture exposing (collatz)


collatz : Int -> Result String Int
collatz start =
    if start > 0 then
        Result.Ok (accumulateCollatz start)

    else
        Result.Err "Only positive numbers are allowed"


accumulateCollatz : Int -> Int
accumulateCollatz start =
    if start == 1 then
        0

    else
        1 + accumulateCollatz (nextStep start)


nextStep : Int -> Int
nextStep n =
    if 0 == modBy 2 n then
        n // 2

    else
        3 * n + 1
