module Quartz.Array exposing (array, elements, idx)

import Array
import Array.Extra
import Maybe.Extra
import Quartz.Type.Iso as Iso
import Quartz.Type.Traversal as Traversal


array : Traversal.Traversal (Array.Array a) (Array.Array b) a b
array =
    Traversal.traversal
        Array.toList
        Array.map


elements : Iso.Iso p l (Array.Array a) (Array.Array b) (List a) (List b)
elements =
    Iso.iso
        Array.toList
        Array.fromList


idx : Int -> Traversal.SimpleTraversal (Array.Array a) a
idx n =
    Traversal.traversal
        (Array.get n >> Maybe.Extra.toList)
        (Array.Extra.update n)
