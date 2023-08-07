module Quartz.Type.Optic exposing (Optic, SimpleOptic)


type alias Optic p l s t a b =
    { over : (a -> b) -> s -> t
    , review : p -> b -> t
    , toListOf : s -> List a
    , view : l -> s -> a
    }


type alias SimpleOptic p l s a =
    Optic p l s s a a
