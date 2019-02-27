module PhoneNumber exposing (getNumber)


getNumber : String -> Maybe String
getNumber phoneNumber =
    let
        formattedNumber =
            String.filter Char.isDigit phoneNumber
                |> trimCountryCode
    in
    if validateNumber formattedNumber then
        Maybe.Just formattedNumber

    else
        Nothing


validateNumber : String -> Bool
validateNumber phoneNumber =
    let
        exchangeCode =
            String.slice 3 6 phoneNumber
    in
    String.length phoneNumber
        == 10
        && (not <| String.startsWith "0" phoneNumber)
        && (not <| String.startsWith "0" exchangeCode)
        && (not <| String.startsWith "1" exchangeCode)


trimCountryCode : String -> String
trimCountryCode fullNumber =
    if String.startsWith "1" fullNumber then
        String.dropLeft 1 fullNumber

    else
        fullNumber
