module Quartz.Type.Traversal exposing (SimpleTraversal, Traversal, traversal)

import Quartz.Type.No as No
import Quartz.Type.Optic as Optic


type alias Traversal s t a b =
    Optic.Optic No.No No.No s t a b


type alias SimpleTraversal s a =
    Traversal s s a a


traversal : (s -> List a) -> ((a -> b) -> s -> t) -> Traversal s t a b
traversal s2l f =
    { over = f
    , review = No.no >> always
    , toListOf = s2l
    , view = No.no >> always
    }
