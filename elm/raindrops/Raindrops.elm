module Raindrops exposing (raindrops)


raindrops : Int -> String
raindrops number =
    let
        output =
            pling number ++ plang number ++ plong number
    in
    case output of
        "" ->
            String.fromInt number

        _ ->
            output


pling : Int -> String
pling =
    noise 3 "Pling"


plang : Int -> String
plang =
    noise 5 "Plang"


plong : Int -> String
plong =
    noise 7 "Plong"


noise : Int -> String -> Int -> String
noise mod sound number =
    if modBy mod number == 0 then
        sound

    else
        ""
