module TwelveDays exposing (recite)


recite : Int -> Int -> List String
recite start stop =
    List.range start stop
        |> List.map getVerse


getVerse : Int -> String
getVerse day =
    "On the " ++ Tuple.first (getDay day) ++ " day of Christmas my true love gave to me, " ++ getGifts day


getDay : Int -> (String, String)
getDay day =
    case day of
        1  -> ("first", "a Partridge in a Pear Tree.")
        2  -> ("second", "two Turtle Doves, and ")
        3  -> ("third", "three French Hens, ")
        4  -> ("fourth", "four Calling Birds, ")
        5  -> ("fifth", "five Gold Rings, ")
        6  -> ("sixth", "six Geese-a-Laying, ")
        7  -> ("seventh", "seven Swans-a-Swimming, ")
        8  -> ("eighth", "eight Maids-a-Milking, ")
        9  -> ("ninth", "nine Ladies Dancing, ")
        10 -> ("tenth", "ten Lords-a-Leaping, ")
        11 -> ("eleventh", "eleven Pipers Piping, ")
        12 -> ("twelfth", "twelve Drummers Drumming, ")
        _  -> ("unknown", "some number of mystery gifts, ")


getGifts : Int -> String
getGifts day =
    List.range 1 day
        |> List.map getDay
        |> List.map Tuple.second
        |> List.reverse
        |> String.join ""
