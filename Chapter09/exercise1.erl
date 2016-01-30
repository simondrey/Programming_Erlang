-module(exercise1).
-compile(export_all).

%% Write some very small modules that export a single function. Write type specifications for the exported functions. In the functions make some type errors; then run the dialyzer on these programs and try to understand the error messages. Sometimes you’ll make an error but the dialyzer will not find the error; stare hard at the program to try to work out why you did not get the error you expected.

-spec named_sum(name(), integer(), integer()) -> named_integer().

-type name() :: string().
-type named_integer() :: {name(), integer()}.


named_sum(Name, N, M) ->
    %{Name, N + M}. % correct
    N + M.
