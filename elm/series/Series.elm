module Series exposing (slices)


slices : Int -> String -> Result String (List (List Int))
slices size input =
    if String.length input == 0 then
        Err "series cannot be empty"

    else if size > String.length input then
        Err "slice length cannot be greater than series length"

    else if size == 0 then
        Err "slice length cannot be zero"

    else if size < 0 then
        Err "slice length cannot be negative"

    else
        Ok <| getSlices size input


getSlices : Int -> String -> List (List Int)
getSlices size input =
    if size == String.length input then
        [ intList input ]

    else
        intList (String.left size input) :: getSlices size (String.dropLeft 1 input)


intList : String -> List Int
intList input =
    input
        |> String.split ""
        |> List.map String.toInt
        |> List.map (Maybe.withDefault 0)
