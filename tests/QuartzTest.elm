module QuartzTest exposing (test)

import Expect
import Quartz as Qz
import Test


test : Test.Test
test =
    Test.describe "Quartz"
        [ Test.describe "view"
            [ Test.test "works" <|
                \_ ->
                    Expect.equal
                        (Qz.view Qz.first ( 1, 2 ))
                        1
            , Test.test "works composed" <|
                \_ ->
                    Expect.equal
                        (Qz.view (Qz.first |> Qz.andThen Qz.second) ( ( 1, 2 ), 3 ))
                        2
            ]
        , Test.describe "over"
            [ Test.test "works" <|
                \_ ->
                    Expect.equal
                        (Qz.over Qz.first negate ( 1, 2 ))
                        ( -1, 2 )
            , Test.test "works compose" <|
                \_ ->
                    Expect.equal
                        (Qz.over (Qz.first |> Qz.andThen Qz.second) negate ( ( 1, 2 ), 3 ))
                        ( ( 1, -2 ), 3 )
            ]
        , Test.describe "set"
            [ Test.test "works" <|
                \_ ->
                    Expect.equal
                        (Qz.set Qz.first 3 ( 1, 2 ))
                        ( 3, 2 )
            , Test.test "works composed" <|
                \_ ->
                    Expect.equal
                        (Qz.set (Qz.first |> Qz.andThen Qz.second) 4 ( ( 1, 2 ), 3 ))
                        ( ( 1, 4 ), 3 )
            ]
        , Test.describe "preview"
            [ Test.test "works" <|
                \_ ->
                    Expect.equal
                        (Qz.preview Qz.just <| Just 1)
                        (Just 1)
            , Test.test "works composed" <|
                \_ ->
                    Expect.equal
                        (Qz.preview (Qz.just |> Qz.andThen Qz.ok) <| Just <| Ok 1)
                        (Just 1)
            ]
        , Test.describe "review"
            [ Test.test "works" <|
                \_ ->
                    Expect.equal
                        (Qz.review Qz.just 1)
                        (Just 1)
            , Test.test "works composed" <|
                \_ ->
                    Expect.equal
                        (Qz.review (Qz.just |> Qz.andThen Qz.ok) 1)
                        (Just <| Ok 1)
            ]
        , Test.describe "toListOf"
            [ Test.test "works" <|
                \_ ->
                    Expect.equal
                        (Qz.toListOf Qz.list [ 1, 2 ])
                        [ 1, 2 ]
            , Test.test "works composed" <|
                \_ ->
                    Expect.equal
                        (Qz.toListOf (Qz.list |> Qz.andThen Qz.list) [ [ 1 ], [ 2, 3 ] ])
                        [ 1, 2, 3 ]
            ]
        ]
