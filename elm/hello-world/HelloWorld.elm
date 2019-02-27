module HelloWorld exposing (helloWorld)

helloWorld : Maybe String -> String
helloWorld name =
    case name of
        Nothing ->
            "Hello, World!"

        Just aName ->
            "Hello, " ++ aName ++ "!"
