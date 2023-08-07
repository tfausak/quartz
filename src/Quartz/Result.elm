module Quartz.Result exposing (err, ok)

import Quartz.Type.Prism as Prism
import Result.Extra


err : Prism.Prism p (Result a x) (Result b x) a b
err =
    Prism.prism
        Err
        (Result.Extra.unpack Ok (Ok >> Err))


ok : Prism.Prism p (Result x a) (Result x b) a b
ok =
    Prism.prism
        Ok
        (Result.mapError Err)
