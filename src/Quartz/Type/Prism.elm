module Quartz.Type.Prism exposing (Prism, SimplePrism, prism)

import Quartz.Type.No as No
import Quartz.Type.Optic as Optic
import Result.Extra


type alias Prism p s t a b =
    Optic.Optic p No.No s t a b


type alias SimplePrism p s a =
    Prism p s s a a


prism : (b -> t) -> (s -> Result t a) -> Prism p s t a b
prism b2t s2r =
    { over = \a2b -> s2r >> Result.Extra.unpack identity (a2b >> b2t)
    , review = always b2t
    , toListOf = s2r >> Result.Extra.unpack (always []) List.singleton
    , view = No.no >> always
    }
