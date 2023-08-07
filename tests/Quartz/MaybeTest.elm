module Quartz.MaybeTest exposing (test)

import Expect
import Quartz as Q
import Test


test : Test.Test
test =
    Test.describe "Quartz.Maybe"
        [ Test.describe "nothing"
            [ Test.describe "is"
                [ Test.test "return true with nothing" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.nothing Nothing)
                            True
                , Test.test "return false with just" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.nothing <| Just 1)
                            False
                ]
            , Test.describe "over"
                [ Test.test "works with nothing" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.nothing identity Nothing)
                            Nothing
                , Test.test "works with just" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.nothing identity <| Just 1)
                            (Just 1)
                ]
            , Test.describe "preview"
                [ Test.test "returns just with nothing" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.nothing Nothing)
                            (Just ())
                , Test.test "returns nothing with just" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.nothing <| Just 1)
                            Nothing
                ]
            , Test.describe "review"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.review Q.nothing ())
                            Nothing
                ]
            , Test.describe "set"
                [ Test.test "works with nothing" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.nothing () Nothing)
                            Nothing
                , Test.test "works with just" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.nothing () <| Just 1)
                            (Just 1)
                ]
            , Test.describe "toListOf"
                [ Test.test "works with nothing" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.nothing Nothing)
                            [ () ]
                , Test.test "works with just" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.nothing <| Just 1)
                            []
                ]
            ]
        , Test.describe "just"
            [ Test.describe "andThen"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.just |> Q.andThen Q.just) <| Just <| Just 1)
                            [ 1 ]
                ]
            , Test.describe "is"
                [ Test.test "return false with nothing" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.just Nothing)
                            False
                , Test.test "return true with just" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.just <| Just 1)
                            True
                ]
            , Test.describe "over"
                [ Test.test "works with nothing" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.just identity Nothing)
                            Nothing
                , Test.test "works with just" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.just negate <| Just 1)
                            (Just -1)
                ]
            , Test.describe "preview"
                [ Test.test "returns nothing with nothing" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.just Nothing)
                            Nothing
                , Test.test "returns just with just" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.just <| Just 1)
                            (Just 1)
                ]
            , Test.describe "review"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.review Q.just 1)
                            (Just 1)
                ]
            , Test.describe "set"
                [ Test.test "works with nothing" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.just 3 Nothing)
                            Nothing
                , Test.test "works with just" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.just 3 <| Just 1)
                            (Just 3)
                ]
            , Test.describe "toListOf"
                [ Test.test "works with nothing" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.just Nothing)
                            []
                , Test.test "works with just" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.just <| Just 1)
                            [ 1 ]
                ]
            ]
        ]
