module ScrabbleScore exposing (scoreWord)


scoreWord : String -> Int
scoreWord x =
    String.toUpper x
        |> String.toList
        |> List.map (\char -> scoreLetter (String.fromChar char))
        |> List.sum


scoreLetter : String -> Int
scoreLetter letter =
    if tenPointer letter then
        10

    else if eightPointer letter then
        8

    else if fivePointer letter then
        5

    else if fourPointer letter then
        4

    else if threePointer letter then
        3

    else if twoPointer letter then
        2

    else if onePointer letter then
        1

    else
        0


tenPointer : String -> Bool
tenPointer letter =
    String.contains letter "QZ"


eightPointer : String -> Bool
eightPointer letter =
    String.contains letter "JX"


fivePointer : String -> Bool
fivePointer letter =
    letter == "K"


fourPointer : String -> Bool
fourPointer letter =
    String.contains letter "FHVWY"


threePointer : String -> Bool
threePointer letter =
    String.contains letter "BCMP"


twoPointer : String -> Bool
twoPointer letter =
    String.contains letter "DG"


onePointer : String -> Bool
onePointer letter =
    String.contains letter "AEIOULNRST"
