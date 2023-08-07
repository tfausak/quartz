module Quartz.ArrayTest exposing (test)

import Array
import Expect
import Quartz as Q
import Test


test : Test.Test
test =
    Test.describe "Quartz.Array"
        [ Test.describe "elements"
            [ Test.describe "is"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.elements Array.empty)
                            True
                ]
            , Test.describe "over"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.elements List.reverse <| Array.fromList [ 1, 2 ])
                            (Array.fromList [ 2, 1 ])
                ]
            , Test.describe "preview"
                [ Test.test "works with an empty array" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.elements Array.empty)
                            (Just [])
                , Test.test "works with a non-empty array" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.elements <| Array.fromList [ 1, 2 ])
                            (Just [ 1, 2 ])
                ]
            , Test.describe "review"
                [ Test.test "works with an empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.review Q.elements [])
                            Array.empty
                , Test.test "works with a non-empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.review Q.elements [ 1, 2 ])
                            (Array.fromList [ 1, 2 ])
                ]
            , Test.describe "set"
                [ Test.test "works with an empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.elements [ 1, 2 ] Array.empty)
                            (Array.fromList [ 1, 2 ])
                , Test.test "works with a non-empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.elements [ 3, 4 ] <| Array.fromList [ 1, 2 ])
                            (Array.fromList [ 3, 4 ])
                ]
            , Test.describe "toListOf"
                [ Test.test "works with an empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.elements Array.empty)
                            [ [] ]
                , Test.test "works with a non-empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.elements <| Array.fromList [ 1, 2 ])
                            [ [ 1, 2 ] ]
                ]
            , Test.describe "view"
                [ Test.test "works with an empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.view Q.elements Array.empty)
                            []
                , Test.test "works with a non-empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.view Q.elements <| Array.fromList [ 1, 2 ])
                            [ 1, 2 ]
                ]
            ]
        , Test.describe "array"
            [ Test.describe "andThen"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.array |> Q.andThen Q.array) <| Array.fromList [ Array.fromList [ 1 ], Array.fromList [ 2, 3 ] ])
                            [ 1, 2, 3 ]
                ]
            , Test.describe "is"
                [ Test.test "works with an empty array" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.array Array.empty)
                            False
                , Test.test "works with a non-empty array" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.array <| Array.fromList [ 1, 2 ])
                            True
                ]
            , Test.describe "over"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.array negate <| Array.fromList [ 1, 2 ])
                            (Array.fromList [ -1, -2 ])
                ]
            , Test.describe "preview"
                [ Test.test "works with an empty array" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.array Array.empty)
                            Nothing
                , Test.test "works with a non-empty array" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.array <| Array.fromList [ 1, 2 ])
                            (Just 1)
                ]
            , Test.describe "set"
                [ Test.test "works with an empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.array 3 Array.empty)
                            Array.empty
                , Test.test "works with a non-empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.array 3 <| Array.fromList [ 1, 2 ])
                            (Array.fromList [ 3, 3 ])
                ]
            , Test.describe "toListOf"
                [ Test.test "works with an empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.array Array.empty)
                            []
                , Test.test "works with a non-empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.array <| Array.fromList [ 1, 2 ])
                            [ 1, 2 ]
                ]
            ]
        , Test.describe "idx"
            [ Test.describe "andThen"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.idx 0 |> Q.andThen (Q.idx 1)) <| Array.fromList [ Array.fromList [ 1, 2 ], Array.fromList [ 3 ] ])
                            [ 2 ]
                ]
            , Test.describe "is"
                [ Test.test "works with an empty array" <|
                    \_ ->
                        Expect.equal
                            (Q.is (Q.idx 0) Array.empty)
                            False
                , Test.test "works with a non-empty array" <|
                    \_ ->
                        Expect.equal
                            (Q.is (Q.idx 0) <| Array.fromList [ 1, 2 ])
                            True
                ]
            , Test.describe "over"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.over (Q.idx 0) negate <| Array.fromList [ 1, 2 ])
                            (Array.fromList [ -1, 2 ])
                ]
            , Test.describe "preview"
                [ Test.test "works with an empty array" <|
                    \_ ->
                        Expect.equal
                            (Q.preview (Q.idx 0) Array.empty)
                            Nothing
                , Test.test "works with a non-empty array" <|
                    \_ ->
                        Expect.equal
                            (Q.preview (Q.idx 0) <| Array.fromList [ 1, 2 ])
                            (Just 1)
                ]
            , Test.describe "set"
                [ Test.test "works with an empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.set (Q.idx 0) 3 Array.empty)
                            Array.empty
                , Test.test "works with a non-empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.set (Q.idx 0) 3 <| Array.fromList [ 1, 2 ])
                            (Array.fromList [ 3, 2 ])
                ]
            , Test.describe "toListOf"
                [ Test.test "works with an empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.idx 0) Array.empty)
                            []
                , Test.test "works with a non-empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.idx 0) <| Array.fromList [ 1, 2 ])
                            [ 1 ]
                ]
            ]
        ]
