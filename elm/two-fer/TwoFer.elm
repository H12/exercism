module TwoFer exposing (twoFer)


twoFer : Maybe String -> String
twoFer name =
    "One for " ++ parseName name ++ ", one for me."


parseName : Maybe String -> String
parseName name =
    Maybe.withDefault "you" name
