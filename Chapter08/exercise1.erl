-module(exercise1).
-export([how_many_functions/1, detailed_info/1]).

how_many_functions(Mod) ->
    [_H1, {exports, Exported_Methods} | _Tail ] = dict:module_info(),
    io:format("Module `~p` exports ~p functions.~n", [Mod, length(Exported_Methods)]).


%% Returns the number of functions with the Arity from the
%% ListOfFuncs (a list produced by the Mod:module_info() function).
nfa(Arity, ListOfFuncs) ->
    length(lists:filter(fun({_FunName, FunArity}) -> FunArity == Arity end, ListOfFuncs)).

detailed_info(Mod) ->
    [_H1, {exports, Exported_Funcs} | _Tail ] = dict:module_info(),
    TotalNumOfFuncs = length(Exported_Funcs),
    io:format("Module `~p` exports ~p functions:~n", [Mod, TotalNumOfFuncs]),
    Arity0 = nfa(0, Exported_Funcs),
    Arity1 = nfa(1, Exported_Funcs),
    Arity2AndMore = TotalNumOfFuncs - Arity0 - Arity1,
    io:format(" - ~p functions with arity 0~n", [Arity0]),
    io:format(" - ~p functions with arity 1~n", [Arity1]),
    io:format(" - ~p functions with arity 2 and more~n", [Arity2AndMore]).


