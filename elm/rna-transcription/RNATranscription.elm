module RNATranscription exposing (toRNA)


toRNA : String -> Result Char String
toRNA dna =
    Result.Ok (String.map mapNucleotide dna)


mapNucleotide : Char -> Char
mapNucleotide dna =
    case dna of
        'C' -> 'G'
        'G' -> 'C'
        'T' -> 'A'
        'A' -> 'U'
        _   -> '?'
