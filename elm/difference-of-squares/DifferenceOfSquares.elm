module DifferenceOfSquares exposing (difference, squareOfSum, sumOfSquares)


squareOfSum : Int -> Int
squareOfSum n =
    squareSum (n - 1) n

squareSum : Int -> Int -> Int
squareSum n sum =
    if n <= 0 then
        sum * sum
    else
        squareSum (n - 1) (n + sum)


sumOfSquares : Int -> Int
sumOfSquares n =
    sumSquares (n - 1) (n * n)

sumSquares : Int -> Int -> Int
sumSquares n sum =
    if n <= 0 then
        sum
    else
        sumSquares (n - 1) (n * n + sum)


difference : Int -> Int
difference n =
    (squareOfSum n) - (sumOfSquares n)
