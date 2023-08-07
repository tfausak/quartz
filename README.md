# Quartz

Lenses and optics for Elm.

This is similar to [Heimdell/elm-optics](https://package.elm-lang.org/packages/Heimdell/elm-optics/3.0.1/).
It's more or less a port of the [Lens](https://hackage.haskell.org/package/lens-5.2.2) or [Optics](https://hackage.haskell.org/package/optics-0.4.2.1) library from Haskell.

Lenses can be useful to update deeply-nested records.
For example, consider the following data types:

    type alias Name =
        { first : String
        , last : String
        }

    type alias Person =
        { name : Name
        }

If you want to update a `Person`'s `Name`, you have to jump through some hoops:

    let
        oldName =
            person.name

        newName =
            { oldName | first = String.trim oldName.first }
    in
    { person | name = newName }

Updates like this can be performed more directly with lenses.
First you'll have to define the lenses:

    import Quartz as Qz

    nameLens : Qz.SimpleLens l Person Name
    nameLens =
        Qz.lens .name <| \ person name -> { person | name = name }

    firstLens : Qz.SimpleLens l Name String
    firstLens =
        Qz.lens .first <| \ name first -> { name | first = first }

Then you can use the lenses to easily perform the update:

    Qz.over (Qz.nameLens |> Qz.andThen Qz.firstLens) String.trim person
