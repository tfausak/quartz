module Quartz.Maybe exposing (just, nothing)

import Maybe.Extra
import Quartz.Type.Prism as Prism


just : Prism.Prism p (Maybe a) (Maybe b) a b
just =
    Prism.prism
        Just
        (Maybe.Extra.unwrap (Err Nothing) Ok)


nothing : Prism.SimplePrism p (Maybe a) ()
nothing =
    Prism.prism
        (always Nothing)
        (Maybe.Extra.unwrap (Ok ()) (Just >> Err))
