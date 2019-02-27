module Gigasecond exposing (add)

import Time


add : Time.Posix -> Time.Posix
add timestamp =
    timestamp
        |> Time.posixToMillis
        |> \millis -> millis + 1000000000000
        |> Time.millisToPosix
