module Quartz.List exposing (list, nth)

import List.Extra
import Maybe.Extra
import Quartz.Type.Traversal as Traversal


list : Traversal.Traversal (List a) (List b) a b
list =
    Traversal.traversal identity List.map


nth : Int -> Traversal.SimpleTraversal (List a) a
nth n =
    Traversal.traversal
        (List.Extra.getAt n >> Maybe.Extra.toList)
        (List.Extra.updateAt n)
