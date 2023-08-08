module Quartz.Type.Iso exposing (Iso, SimpleIso, from, iso)

import Quartz.Type.Optic as Optic


type alias Iso p l s t a b =
    Optic.Optic p l s t a b


type alias SimpleIso p l s a =
    Iso p l s s a a


iso : (s -> a) -> (b -> t) -> Iso p l s t a b
iso s2a b2t =
    { over = \a2b -> s2a >> a2b >> b2t
    , review = always b2t
    , toListOf = s2a >> List.singleton
    , view = always s2a
    }


from : Iso () () s t a b -> Iso () () b a t s
from x =
    { over = \t2s -> x.review () >> t2s >> x.view ()
    , review = x.view
    , toListOf = x.review () >> List.singleton
    , view = x.review
    }
