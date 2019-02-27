module Sublist exposing (ListComparison(..), sublist)


type ListComparison
    = Equal
    | Superlist
    | Sublist
    | Unequal


sublist : List a -> List a -> ListComparison
sublist alist blist =
    if alist == blist then
        Equal

    else if isSublist alist blist then
        Sublist

    else if isSublist blist alist then
        Superlist

    else
        Unequal


isSublist : List a -> List a -> Bool
isSublist alist blist =
    if List.take (List.length alist) blist == alist then
        True

    else
        case blist of
            [] ->
                False

            _ :: tail ->
                isSublist alist tail
