module Tests exposing (tests)

import Expect
import HelloWorld exposing (helloWorld)
import Test exposing (..)


tests : Test
tests =
    describe "Hello, World!"
        [ test "Hello with no name" <|
            \() ->
                Expect.equal "Hello, World!" (helloWorld Nothing)
        ,
            test "Hello to a sample name" <|
                \() ->
                    Expect.equal "Hello, Alice!" (helloWorld (Just "Alice"))
        ,
            test "Hello to another sample name" <|
                \() ->
                    Expect.equal "Hello, Bob!" (helloWorld (Just "Bob"))
        ]
