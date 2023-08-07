module Quartz.Tuple exposing (first, second, swap)

import Quartz.Type.Iso as Iso
import Quartz.Type.Lens as Lens


first : Lens.Lens l ( a, x ) ( b, x ) a b
first =
    Lens.lens
        Tuple.first
        (\( _, x ) b -> ( b, x ))


second : Lens.Lens l ( x, a ) ( x, b ) a b
second =
    Lens.lens
        Tuple.second
        (\( x, _ ) b -> ( x, b ))


swap : Iso.Iso p l ( a, b ) ( c, d ) ( b, a ) ( d, c )
swap =
    Iso.iso
        (\( a, b ) -> ( b, a ))
        (\( b, a ) -> ( a, b ))
