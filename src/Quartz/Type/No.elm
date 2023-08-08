module Quartz.Type.No exposing (No, no)


type No
    = No No


no : No -> a
no (No x) =
    let
        y : No
        y =
            x
    in
    no y
