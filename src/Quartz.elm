module Quartz exposing
    ( Optic, SimpleOptic
    , Iso, SimpleIso, iso, from
    , Prism, SimplePrism, prism
    , Lens, SimpleLens, lens
    , Traversal, SimpleTraversal, traversal
    , andThen, is, over, preview, review, set, toListOf, view
    , elements, array, idx
    , pairs, key
    , list, nth
    , nothing, just
    , err, ok
    , swap, first, second
    )

{-|


# Optics

@docs Optic, SimpleOptic


# Isos

@docs Iso, SimpleIso, iso, from


# Prisms

@docs Prism, SimplePrism, prism


# Lenss

@docs Lens, SimpleLens, lens


# Traversals

@docs Traversal, SimpleTraversal, traversal


# Combinators

@docs andThen, is, over, preview, review, set, toListOf, view


# Arrays

@docs elements, array, idx


# Dicts

@docs pairs, key


# Lists

@docs list, nth


# Maybes

@docs nothing, just


# Results

@docs err, ok


# Tuples

@docs swap, first, second

-}

import Array exposing (Array)
import Dict exposing (Dict)
import Quartz.Array
import Quartz.Combinator
import Quartz.Dict
import Quartz.List
import Quartz.Maybe
import Quartz.Result
import Quartz.Tuple
import Quartz.Type.Iso
import Quartz.Type.Lens
import Quartz.Type.Optic
import Quartz.Type.Prism
import Quartz.Type.Traversal


{-| This is the base optic type. All other optics are defined in terms of this
type.

Don't be intimidated by all the type variables! Here's what they mean:

  - `p`: Does this optic support being used as a prism? This will either be
    `()` for "yes" or `Never` for "no".

  - `l`: Does this optic support being used as a lens? Like `p`, this will
    either be `()` for "yes" or `Never` for "no".

  - `s`: This is the input type. Often this is a "big" type like a record.

  - `t`: This is the output type. Often this is the same as the input type, but
    that's not required.

  - `a`: This is the input type of the focused element. Often this is a "small"
    type like one field in a record.

  - `b`: This is the output type of the focused element. Often this is the same
    as the input type, but that's not required.

-}
type alias Optic p l s t a b =
    Quartz.Type.Optic.Optic p l s t a b


{-| This is an `Optic` where the input and output types are the same.
-}
type alias SimpleOptic p l s a =
    Quartz.Type.Optic.SimpleOptic p l s a


{-| This is an `Optic` that represents an isomorphism. Two types are isomorphic
if you can convert between them without losing any information.
-}
type alias Iso p l s t a b =
    Quartz.Type.Iso.Iso p l s t a b


{-| This is an `Iso` where the input and output types are the same.
-}
type alias SimpleIso p l s a =
    Quartz.Type.Iso.SimpleIso p l s a


{-| Use this function to create a new `Iso`. You have to provide conversion
functions for both directions.

    type Name
        = Name String

    nameIso : SimpleIso p l String Name
    nameIso =
        iso Name <| \(Name s) -> s

-}
iso : (s -> a) -> (b -> t) -> Iso p l s t a b
iso =
    Quartz.Type.Iso.iso


{-| Use this function to flip an `Iso` around.

    stringIso : SimpleIso () () Name String
    stringIso =
        from nameIso

-}
from : Iso () () s t a b -> Iso () () b a t s
from =
    Quartz.Type.Iso.from


{-| This is an `Optic` that can be used to represent a constructor. Note that
it cannot be used as a lens.
-}
type alias Prism p s t a b =
    Quartz.Type.Prism.Prism p s t a b


{-| This is a `Prism` where the input and output types are the same.
-}
type alias SimplePrism p s a =
    Quartz.Type.Prism.SimplePrism p s a


{-| Use this function to create a new `Prism`. You have to provide a way to
call the constructor and a way to destructure a value.

    type Number
        = Integral Int
        | Floating Float

    iPrism : SimplePrism p Number Int
    iPrism =
        prism Integral <|
            \n ->
                case n of
                    Integral i ->
                        Ok u

                    _ ->
                        Err n

-}
prism : (b -> t) -> (s -> Result t a) -> Prism p s t a b
prism =
    Quartz.Type.Prism.prism


{-| This is an `Optic` that can be used to represent a field accessor. Note
that it cannot be used as a prism.
-}
type alias Lens l s t a b =
    Quartz.Type.Lens.Lens l s t a b


{-| This is a `Lens` where the input and output types are the same.
-}
type alias SimpleLens l s a =
    Quartz.Type.Lens.SimpleLens l s a


{-| Use this function to create a new `Lens`. You have to provide a way to get
the part out of the whole, and a way to construct the whole with a new part.

    type alias Person =
        { name : String }

    nameLens : SimpleLens l Person Name
    nameLens =
        lens .name <| \person name -> { person | name = name }

-}
lens : (s -> a) -> (s -> b -> t) -> Lens l s t a b
lens =
    Quartz.Type.Lens.lens


{-| This is an `Optic` that may contain zero or many focused values. Note that
it cannot be used as a prism nor a lens.
-}
type alias Traversal s t a b =
    Quartz.Type.Traversal.Traversal s t a b


{-| This is a `Traversal` where the input and output types are the same.
-}
type alias SimpleTraversal s a =
    Quartz.Type.Traversal.SimpleTraversal s a


{-| Use this function to create a new `Traversal`. You have to provide a way to
convert the input into a `List`, as well as a way to map over values in the
input.

    data Pair a =
        Pair a a

    pairTraversal : SimpleTraversal (Pair a) a
    pairTraversal =
        traversal
            (\(Pair a1 a2) -> [ a1, a2 ])
            (\f (Pair a1 a2) -> Pair (f a1) (f a2))

-}
traversal : (s -> List a) -> ((a -> b) -> s -> t) -> Traversal s t a b
traversal =
    Quartz.Type.Traversal.traversal


{-| Composes two `Optic`s. This is meant to be used in a pipeline. The first
argument is the inner `Optic` and the second argument is the outer `Optic`.

    preview (just |> andThen ok) <| Just <| Ok 1
    -- Just 1

-}
andThen : Optic p l u v a b -> Optic p l s t u v -> Optic p l s t a b
andThen =
    Quartz.Combinator.andThen


{-| Returns `True` if the given `Optic` matches, `False` otherwise. Typically
this is used as an alternative to `preview`.

    is just <| Just 1
    -- True

-}
is : Optic p l s t a b -> s -> Bool
is =
    Quartz.Combinator.is


{-| Maps the given function over the `Optic`. If the `Optic` doesn't match,
nothing will happen. See `set` for a similar function that unconditionally sets
the value rather than updating it.

    over just negate <| Just 1
    -- Just -1

-}
over : Optic p l s t a b -> (a -> b) -> s -> t
over =
    Quartz.Combinator.over


{-| Returns `Just` if the `Optic` matches, `Nothing` otherwise. See `toListOf`
for a similar function that can return multiple matches.

    preview ok <| Ok 1
    -- Just 1

-}
preview : Optic p l s t a b -> s -> Maybe a
preview =
    Quartz.Combinator.preview


{-| Creates a new value using the given `Optic`.

    review just 1
    -- Just 1

-}
review : SimpleOptic () l s a -> a -> s
review =
    Quartz.Combinator.review


{-| Sets the small value inside the big value using the provided `Optic`. See
`over` for a similar function that allows modifying the value.

    set first 3 ( 1, 2 )
    -- ( 3, 2 )

-}
set : Optic p l s t a b -> b -> s -> t
set =
    Quartz.Combinator.set


{-| Extracts all of the values that match the provided `Optic`. See `preview`
for a similar function that only returns zero or one value.

    toListOf array <| Array.fromList [ 1, 2 ]
    -- [ 1, 2 ]

-}
toListOf : Optic p l s t a b -> s -> List a
toListOf =
    Quartz.Combinator.toListOf


{-| Extracts a value using the provided `Optic`. See `preview` for a similar
function that works with more types of `Optic`s.

    view first ( 1, 2 )
    -- 1

-}
view : Optic p () s t a b -> s -> a
view =
    Quartz.Combinator.view


{-| Converts between an `Array` and a `List`.

    view elements <| Array.fromList [ 1, 2 ]
    -- [ 1, 2 ]

-}
elements : Iso p l (Array a) (Array b) (List a) (List b)
elements =
    Quartz.Array.elements


{-| Focuses on each element of the `Array`.

    over array negate <| Array.fromList [ 1, 2 ]
    -- Array.fromList [ -1, -2 ]

-}
array : Traversal (Array a) (Array b) a b
array =
    Quartz.Array.array


{-| Focuses on the element at the given index of the `Array`.

    preview (idx 1) <| Array.fromList [ 1, 2 ]
    -- Just 2

-}
idx : Int -> SimpleTraversal (Array a) a
idx =
    Quartz.Array.idx


{-| Converts between a `Dict` and a `List` of pairs.

    view pairs <| Dict.singleton "k" "v"
    -- [ ( "k", "v" ) ]

-}
pairs : Iso p l (Dict comparable1 a) (Dict comparable2 a) (List ( comparable1, a )) (List ( comparable2, a ))
pairs =
    Quartz.Dict.pairs


{-| Focuses on the given key in the `Dict`.

    preview (key "k") (Dict.singleton "k" "v")
    -- Just "v"

-}
key : comparable -> SimpleTraversal (Dict comparable a) a
key =
    Quartz.Dict.key


{-| Focuses on each element of the `List`.

    over list negate [ 1, 2 ]
    -- [ -1, -2 ]

-}
list : Traversal (List a) (List b) a b
list =
    Quartz.List.list


{-| Focuses on the element at the given index of the `List`.

    preview (nth 1) [ 1, 2 ]
    -- Just 2

-}
nth : Int -> SimpleTraversal (List a) a
nth =
    Quartz.List.nth


{-| Focuses on the `Nothing` variant of a `Maybe`.

    review nothing ()
    -- Nothing

-}
nothing : SimplePrism p (Maybe a) ()
nothing =
    Quartz.Maybe.nothing


{-| Focuses on the `Just` variant of a `Maybe`.

    review just "success"
    -- Just "success"

-}
just : Prism p (Maybe a) (Maybe b) a b
just =
    Quartz.Maybe.just


{-| Focuses on the `Err` variant of a `Result`.

    review err "failure"
    -- Err "failure"

-}
err : Prism p (Result a x) (Result b x) a b
err =
    Quartz.Result.err


{-| Focuses on the `Ok` variant of a `Result`.

    review ok "success"
    -- Ok "success"

-}
ok : Prism p (Result x a) (Result x b) a b
ok =
    Quartz.Result.ok


{-| Swaps the first and second elements of a tuple.

    view swap ( 1, 2 )
    -- ( 2, 1 )

-}
swap : Iso p l ( a, b ) ( c, d ) ( b, a ) ( d, c )
swap =
    Quartz.Tuple.swap


{-| Focuses on the first element of a tuple.

    view first ( 1, 2 )
    -- 1

-}
first : Lens l ( a, x ) ( b, x ) a b
first =
    Quartz.Tuple.first


{-| Focuses on the second element of a tuple.

    view second ( 1, 2 )
    -- 2

-}
second : Lens l ( x, a ) ( x, b ) a b
second =
    Quartz.Tuple.second
