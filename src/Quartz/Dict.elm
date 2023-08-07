module Quartz.Dict exposing (key, pairs)

import Dict
import Maybe.Extra
import Quartz.Type.Iso as Iso
import Quartz.Type.Traversal as Traversal


key : comparable -> Traversal.SimpleTraversal (Dict.Dict comparable a) a
key k =
    Traversal.traversal
        (Dict.get k >> Maybe.Extra.toList)
        (Maybe.map >> Dict.update k)


pairs : Iso.Iso p l (Dict.Dict comparable1 a) (Dict.Dict comparable2 b) (List ( comparable1, a )) (List ( comparable2, b ))
pairs =
    Iso.iso
        Dict.toList
        Dict.fromList
