module Quartz.Type.Lens exposing (Lens, SimpleLens, lens)

import Quartz.Type.Optic as Optic


type alias Lens l s t a b =
    Optic.Optic Never l s t a b


type alias SimpleLens l s a =
    Lens l s s a a


lens : (s -> a) -> (s -> b -> t) -> Lens l s t a b
lens s2a sb2t =
    { over = \a2b s -> s2a s |> a2b |> sb2t s
    , review = never >> always
    , toListOf = s2a >> List.singleton
    , view = always s2a
    }
