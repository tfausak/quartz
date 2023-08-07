module Quartz.ListTest exposing (test)

import Expect
import Quartz as Q
import Test


test : Test.Test
test =
    Test.describe "Quartz.List"
        [ Test.describe "list"
            [ Test.describe "andThen"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.list |> Q.andThen Q.list) [ [ 1 ], [ 2, 3 ] ])
                            [ 1, 2, 3 ]
                ]
            , Test.describe "is"
                [ Test.test "returns false with an empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.list [])
                            False
                , Test.test "returns true with a non-empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.list [ 1, 2 ])
                            True
                ]
            , Test.describe "over"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.list negate [ 1, 2 ])
                            [ -1, -2 ]
                ]
            , Test.describe "preview"
                [ Test.test "returns nothing with an empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.list [])
                            Nothing
                , Test.test "returns just with a non-empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.list [ 1, 2 ])
                            (Just 1)
                ]
            , Test.describe "set"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.list 3 [ 1, 2 ])
                            [ 3, 3 ]
                ]
            , Test.describe "toListOf"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.list [ 1, 2 ])
                            [ 1, 2 ]
                ]
            ]
        , Test.describe "nth"
            [ Test.describe "andThen"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.nth 0 |> Q.andThen (Q.nth 1)) [ [ 1, 2 ] ])
                            [ 2 ]
                ]
            , Test.describe "is"
                [ Test.test "returns false without a match" <|
                    \_ ->
                        Expect.equal
                            (Q.is (Q.nth 0) [])
                            False
                , Test.test "returns true with a match" <|
                    \_ ->
                        Expect.equal
                            (Q.is (Q.nth 0) [ 1 ])
                            True
                ]
            , Test.describe "over"
                [ Test.test "does nothing without a match" <|
                    \_ ->
                        Expect.equal
                            (Q.over (Q.nth 0) negate [])
                            []
                , Test.test "works with a match" <|
                    \_ ->
                        Expect.equal
                            (Q.over (Q.nth 0) negate [ 1, 2 ])
                            [ -1, 2 ]
                ]
            , Test.describe "preview"
                [ Test.test "returns nothing without a match" <|
                    \_ ->
                        Expect.equal
                            (Q.preview (Q.nth 0) [])
                            Nothing
                , Test.test "returns just with a match" <|
                    \_ ->
                        Expect.equal
                            (Q.preview (Q.nth 0) [ 1, 2 ])
                            (Just 1)
                ]
            , Test.describe "set"
                [ Test.test "does nothing without a match" <|
                    \_ ->
                        Expect.equal
                            (Q.set (Q.nth 0) 3 [])
                            []
                , Test.test "works with a match" <|
                    \_ ->
                        Expect.equal
                            (Q.set (Q.nth 0) 3 [ 1, 2 ])
                            [ 3, 2 ]
                ]
            , Test.describe "toListOf"
                [ Test.test "returns an empty list with no match" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.nth 0) [])
                            []
                , Test.test "returns a singleton list with a match" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.nth 0) [ 1, 2 ])
                            [ 1 ]
                ]
            ]
        ]
