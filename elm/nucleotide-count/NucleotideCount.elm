module NucleotideCount exposing (nucleotideCounts)


type alias NucleotideCounts =
    { a : Int
    , t : Int
    , c : Int
    , g : Int
    }


nucleotideCounts : String -> NucleotideCounts
nucleotideCounts sequence =
    sequence
        |> String.toList
        |> List.foldl incrementCount (NucleotideCounts 0 0 0 0)


incrementCount : Char -> NucleotideCounts -> NucleotideCounts
incrementCount char counts =
    case char of
        'A' ->
            { counts | a = counts.a + 1 }

        'T' ->
            { counts | t = counts.t + 1 }

        'C' ->
            { counts | c = counts.c + 1 }

        'G' ->
            { counts | g = counts.g + 1 }

        _ ->
            counts
