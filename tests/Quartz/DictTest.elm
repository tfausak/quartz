module Quartz.DictTest exposing (test)

import Dict
import Expect
import Quartz as Q
import Test


test : Test.Test
test =
    Test.describe "Quartz.Dict"
        [ Test.describe "pairs"
            [ Test.describe "is"
                [ Test.test "works with an empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.pairs Dict.empty)
                            True
                , Test.test "works with a non-empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.is Q.pairs <| Dict.singleton "k" "v")
                            True
                ]
            , Test.describe "over"
                [ Test.test "works with an empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.pairs identity Dict.empty)
                            Dict.empty
                , Test.test "works with a non-empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.over Q.pairs (List.map (\( k, v ) -> ( k ++ ":", v ++ "!" ))) <| Dict.singleton "k" "v")
                            (Dict.singleton "k:" "v!")
                ]
            , Test.describe "preview"
                [ Test.test "works with an empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.pairs Dict.empty)
                            (Just [])
                , Test.test "works with a non-empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.preview Q.pairs <| Dict.singleton "k" "v")
                            (Just [ ( "k", "v" ) ])
                ]
            , Test.describe "review"
                [ Test.test "works with an empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.review Q.pairs [])
                            Dict.empty
                , Test.test "works with a non-empty list" <|
                    \_ ->
                        Expect.equal
                            (Q.review Q.pairs [ ( "k", "v" ) ])
                            (Dict.singleton "k" "v")
                ]
            , Test.describe "set"
                [ Test.test "works with an empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.pairs [ ( "k", "v" ) ] Dict.empty)
                            (Dict.singleton "k" "v")
                , Test.test "works with a non-empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.set Q.pairs [ ( "k", "v2" ) ] <| Dict.singleton "k" "v1")
                            (Dict.singleton "k" "v2")
                ]
            , Test.describe "toListOf"
                [ Test.test "works with an empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.pairs Dict.empty)
                            [ [] ]
                , Test.test "works with a non-empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf Q.pairs <| Dict.singleton "k" "v")
                            [ [ ( "k", "v" ) ] ]
                ]
            , Test.describe "view"
                [ Test.test "works with an empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.view Q.pairs Dict.empty)
                            []
                , Test.test "works with a non-empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.view Q.pairs <| Dict.singleton "k" "v")
                            [ ( "k", "v" ) ]
                ]
            ]
        , Test.describe "key"
            [ Test.describe "andThen"
                [ Test.test "works" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.key "k1" |> Q.andThen (Q.key "k2")) <| Dict.singleton "k1" <| Dict.singleton "k2" 1)
                            [ 1 ]
                ]
            , Test.describe "is"
                [ Test.test "works with an empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.is (Q.key "k") Dict.empty)
                            False
                , Test.test "works with a non-empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.is (Q.key "k") <| Dict.singleton "k" 1)
                            True
                ]
            , Test.describe "over"
                [ Test.test "works with an empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.over (Q.key "k") negate Dict.empty)
                            Dict.empty
                , Test.test "works with a non-empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.over (Q.key "k") negate <| Dict.singleton "k" 1)
                            (Dict.singleton "k" -1)
                ]
            , Test.describe "preview"
                [ Test.test "works with an empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.preview (Q.key "k") Dict.empty)
                            Nothing
                , Test.test "works with a non-empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.preview (Q.key "k") <| Dict.singleton "k" 1)
                            (Just 1)
                ]
            , Test.describe "set"
                [ Test.test "works with an empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.set (Q.key "k") 1 Dict.empty)
                            Dict.empty
                , Test.test "works with a non-empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.set (Q.key "k") "v2" <| Dict.singleton "k" "v1")
                            (Dict.singleton "k" "v2")
                ]
            , Test.describe "toListOf"
                [ Test.test "works with an empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.key "k") Dict.empty)
                            []
                , Test.test "works with a non-empty dict" <|
                    \_ ->
                        Expect.equal
                            (Q.toListOf (Q.key "k") <| Dict.singleton "k" 1)
                            [ 1 ]
                ]
            ]
        ]
