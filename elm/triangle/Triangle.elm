module Triangle exposing (Triangle(..), triangleKind)


type Triangle
    = Equilateral
    | Isosceles
    | Scalene


triangleKind : number -> number -> number -> Result String Triangle
triangleKind x y z =
    if invalidLengths x y z then
        Result.Err "Invalid lengths"

    else if inequal x y z then
        Result.Err "Violates inequality"

    else if allEqual x y z then
        Result.Ok Equilateral

    else if someEqual x y z then
        Result.Ok Isosceles

    else
        Result.Ok Scalene


invalidLengths : number -> number -> number -> Bool
invalidLengths x y z =
    x <= 0 || y <= 0 || z <= 0


inequal : number -> number -> number -> Bool
inequal x y z =
    max x y
        |> max z
        |> (\longest -> longest > x + y + z - longest)


allEqual : number -> number -> number -> Bool
allEqual x y z =
    x == y && y == z && z == x


someEqual : number -> number -> number -> Bool
someEqual x y z =
    x == y || y == z || z == x
