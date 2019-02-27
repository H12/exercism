module Strain exposing (discard, keep)

predicatedCons : (a -> Bool) -> (a -> List a -> List a)
predicatedCons predicate =
    \x acc ->
        if predicate x then
            x :: acc
        else
            acc


keep : (a -> Bool) -> List a -> List a
keep predicate list =
    List.foldr (predicatedCons predicate) [] list


discard : (a -> Bool) -> List a -> List a
discard predicate list =
    List.filter (not << predicate) list

