module ListOps exposing
    ( append
    , concat
    , filter
    , foldl
    , foldr
    , length
    , map
    , reverse
    )


length : List a -> Int
length list =
    case list of
        [] ->
            0

        _ :: tail ->
            1 + length tail


reverse : List a -> List a
reverse list =
    case list of
        [] ->
            []

        head :: tail ->
            foldl (::) [ head ] tail


foldl : (a -> b -> b) -> b -> List a -> b
foldl f acc list =
    case list of
        [] ->
            acc

        head :: tail ->
            foldl f (f head acc) tail


foldr : (a -> b -> b) -> b -> List a -> b
foldr f acc list =
    list |> reverse |> foldl f acc


map : (a -> b) -> List a -> List b
map f list =
    case list of
        [] ->
            []

        head :: tail ->
            head
                |> f
                |> (\mappedHead -> mappedHead :: map f tail)


filter : (a -> Bool) -> List a -> List a
filter f list =
    case list of
        [] ->
            []

        head :: tail ->
            if f head then
                head :: filter f tail

            else
                filter f tail


append : List a -> List a -> List a
append xs ys =
    let
        reversed =
            reverse xs
    in
    case reversed of
        [] ->
            ys

        last :: front ->
            append (reverse front) (last :: ys)


concat : List (List a) -> List a
concat list =
    case list of
        [] ->
            []

        head :: tail ->
            append head <| concat tail
