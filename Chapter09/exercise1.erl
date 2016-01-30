-module(exercise1).
-compile(export_all).

-spec named_sum(name(), integer(), integer()) -> named_integer().

-type name() :: string().
-type named_integer() :: {name(), integer()}.


named_sum(Name, N, M) ->
    %{Name, N + M}. % correct
    N + M.
