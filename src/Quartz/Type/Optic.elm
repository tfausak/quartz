module Quartz.Type.Optic exposing (Optic, SimpleOptic, re)


type alias Optic p l s t a b =
    { over : (a -> b) -> s -> t
    , review : p -> b -> t
    , toListOf : s -> List a
    , view : l -> s -> a
    }


type alias SimpleOptic p l s a =
    Optic p l s s a a


re : Optic () () s t a b -> Optic p l b a t s
re optic =
    let
        s2a : s -> a
        s2a =
            optic.view ()

        b2t : b -> t
        b2t =
            optic.review ()
    in
    { over = \t2s -> b2t >> t2s >> s2a
    , review = always s2a
    , toListOf = b2t >> List.singleton
    , view = always b2t
    }
