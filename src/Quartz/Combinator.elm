module Quartz.Combinator exposing (andThen, is, over, preview, review, set, toListOf, view)

import Maybe.Extra
import Quartz.Type.Optic as Optic
import Quartz.Type.Yes as Yes


andThen : Optic.Optic p l u v a b -> Optic.Optic p l s t u v -> Optic.Optic p l s t a b
andThen inner outer =
    { over = inner.over >> outer.over
    , review = \p -> inner.review p >> outer.review p
    , toListOf = outer.toListOf >> List.concatMap inner.toListOf
    , view = \l -> outer.view l >> inner.view l
    }


is : Optic.Optic p l s t a b -> s -> Bool
is optic =
    preview optic >> Maybe.Extra.isJust


over : Optic.Optic p l s t a b -> (a -> b) -> s -> t
over =
    .over


preview : Optic.Optic p l s t a b -> s -> Maybe a
preview optic =
    optic.toListOf >> List.head


review : Optic.Optic Yes.Yes l s t a b -> b -> t
review optic =
    optic.review Yes.Yes


set : Optic.Optic p l s t a b -> b -> s -> t
set optic =
    always >> optic.over


toListOf : Optic.Optic p l s t a b -> s -> List a
toListOf =
    .toListOf


view : Optic.Optic p Yes.Yes s t a b -> s -> a
view optic =
    optic.view Yes.Yes
