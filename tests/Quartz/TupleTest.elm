module Quartz.TupleTest exposing (test)

import Expect
import Quartz as Q
import Test


test : Test.Test
test =
    Test.describe "Quartz.Tuple"
        [ Test.describe "swap"
            [ Test.describe "andThen"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.swap |> Q.andThen Q.swap) ( 1, 2 ))
                            [ ( 1, 2 ) ]
                ]
            , Test.describe "is"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.swap ( 1, 2 ))
                            True
                ]
            , Test.describe "over"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.swap identity ( 1, 2 ))
                            ( 1, 2 )
                ]
            , Test.describe "preview"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.swap ( 1, 2 ))
                            (Just ( 2, 1 ))
                ]
            , Test.describe "review"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.review Q.swap ( 1, 2 ))
                            ( 2, 1 )
                ]
            , Test.describe "set"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.swap ( 3, 4 ) ( 1, 2 ))
                            ( 4, 3 )
                ]
            , Test.describe "toListOf"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.swap ( 1, 2 ))
                            [ ( 2, 1 ) ]
                ]
            , Test.describe "view"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.view Q.swap ( 1, 2 ))
                            ( 2, 1 )
                ]
            ]
        , Test.describe "first"
            [ Test.describe "andThen"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.first |> Q.andThen Q.first) ( ( 1, 2 ), 3 ))
                            [ 1 ]
                ]
            , Test.describe "is"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.first ( 1, 2 ))
                            True
                ]
            , Test.describe "over"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.first negate ( 1, 2 ))
                            ( -1, 2 )
                ]
            , Test.describe "preview"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.first ( 1, 2 ))
                            (Just 1)
                ]
            , Test.describe "set"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.first 3 ( 1, 2 ))
                            ( 3, 2 )
                ]
            , Test.describe "toListOf"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.first ( 1, 2 ))
                            [ 1 ]
                ]
            , Test.describe "view"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.view Q.first ( 1, 2 ))
                            1
                ]
            ]
        , Test.describe "second"
            [ Test.describe "andThen"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.second |> Q.andThen Q.second) ( 1, ( 2, 3 ) ))
                            [ 3 ]
                ]
            , Test.describe "is"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.second ( 1, 2 ))
                            True
                ]
            , Test.describe "over"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.second negate ( 1, 2 ))
                            ( 1, -2 )
                ]
            , Test.describe "preview"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.second ( 1, 2 ))
                            (Just 2)
                ]
            , Test.describe "set"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.second 3 ( 1, 2 ))
                            ( 1, 3 )
                ]
            , Test.describe "toListOf"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.second ( 1, 2 ))
                            [ 2 ]
                ]
            , Test.describe "view"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.view Q.second ( 1, 2 ))
                            2
                ]
            ]
        ]
