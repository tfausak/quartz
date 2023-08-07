module Quartz.ResultTest exposing (test)

import Expect
import Quartz as Q
import Test


test : Test.Test
test =
    Test.describe "Quartz.Result"
        [ Test.describe "err"
            [ Test.describe "andThen"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.err |> Q.andThen Q.err) <| Err <| Err 1)
                            [ 1 ]
                ]
            , Test.describe "is"
                [ Test.test "returns true with err" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.err <| Err 1)
                            True
                , Test.test "returns false with ok" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.err <| Ok 1)
                            False
                ]
            , Test.describe "over"
                [ Test.test "works with err" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.err negate <| Err 1)
                            (Err -1)
                , Test.test "works with ok" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.err negate <| Ok 1)
                            (Ok 1)
                ]
            , Test.describe "preview"
                [ Test.test "returns just with err" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.err <| Err 1)
                            (Just 1)
                , Test.test "returns nothing with ok" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.err <| Ok 1)
                            Nothing
                ]
            , Test.describe "review"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.review Q.err 1)
                            (Err 1)
                ]
            , Test.describe "set"
                [ Test.test "works with err" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.err 3 <| Err 1)
                            (Err 3)
                , Test.test "works with ok" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.err 3 <| Ok 1)
                            (Ok 1)
                ]
            , Test.describe "toListOf"
                [ Test.test "works with err" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.err <| Err 1)
                            [ 1 ]
                , Test.test "works with ok" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.err <| Ok 1)
                            []
                ]
            ]
        , Test.describe "ok"
            [ Test.describe "andThen"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.ok |> Q.andThen Q.ok) <| Ok <| Ok 1)
                            [ 1 ]
                ]
            , Test.describe "is"
                [ Test.test "returns false with err" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.ok <| Err 1)
                            False
                , Test.test "returns true with ok" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.ok <| Ok 1)
                            True
                ]
            , Test.describe "over"
                [ Test.test "works with err" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.ok negate <| Err 1)
                            (Err 1)
                , Test.test "works with ok" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.ok negate <| Ok 1)
                            (Ok -1)
                ]
            , Test.describe "preview"
                [ Test.test "returns nothing with err" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.ok <| Err 1)
                            Nothing
                , Test.test "returns just with ok" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.ok <| Ok 1)
                            (Just 1)
                ]
            , Test.describe "review"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.review Q.ok 1)
                            (Ok 1)
                ]
            , Test.describe "set"
                [ Test.test "works with err" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.ok 3 <| Err 1)
                            (Err 1)
                , Test.test "works with ok" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.ok 3 <| Ok 1)
                            (Ok 3)
                ]
            , Test.describe "toListOf"
                [ Test.test "works with err" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.ok <| Err 1)
                            []
                , Test.test "works with ok" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.ok <| Ok 1)
                            [ 1 ]
                ]
            ]
        ]
