module Leap exposing (isLeapYear)


isLeapYear : Int -> Bool
isLeapYear year =
    isDivisibleBy 4 year && (not (isDivisibleBy 100 year) || isDivisibleBy 400 year)


isDivisibleBy : Int -> Int -> Bool
isDivisibleBy divisor year =
    0 == modBy divisor year
