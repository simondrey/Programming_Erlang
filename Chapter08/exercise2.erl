-module(exercise2).
-export([metmf/0, mcfn/0, mcfn2/0, aufn/0, test/0]).
%-compile(export_all).

%% The command code:all_loaded() returns a list of {Mod,File} pairs of all
%% modules that have been loaded into the Erlang system. Use the BIF
%% Mod:module_info() to find out about these modules. Write functions to
%% determine which module exports the most functions and which function name is
%% the most common. Write a function to find all unambiguous function names,
%% that is, function names that are used in only one module.

list_all_modules() ->
    Mods = code:all_loaded(),
    TakeFirst = fun({First, _Second}) -> First end,
    lists:map(TakeFirst, Mods).

% List exported functions by module Mod
lef(Mod) ->
    [_H1, {exports, ExportedFuncs} | _Tail ] = Mod:module_info(),
    ExportedFuncs.

% Details about loaded modules
dalm() ->
    Mods = code:all_loaded(),
    %lists:map(fun({Mod, _FileName}) -> Lef = lef(Mod), [Mod, Lef, length(Lef)] end, Mods).
    [[Mod, lef(Mod), length(lef(Mod))] || {Mod,_FileName} <- Mods].

% Which module does export the most functions?
metmf() ->		      
    ModsWithExports = dalm(),
    % Sort by number of exported functions
    OrderingFun = fun([_M1, _E1, N1], [_M2, _E2, N2]) -> N1 =< N2 end, 
    ModsSorted = lists:sort(OrderingFun, ModsWithExports),
    hd(lists:last(ModsSorted)).

% Most common function name among loaded modules
mcfn() ->
    hd(loafwc(dn)).

mcfn2() ->
    [ H1, H2, H3 | _Tail ] = loafwc(dn),
    [ H1, H2, H3 ].
    
% List all unambiguous function names that is, function names that are used in only one module
aufn() ->
    [ Fun || {Fun, 1} <- loafwc(up) ].

count_dups(OrderedList) -> count_dups(OrderedList, []).

count_dups([], Any) -> 
    Any;
count_dups([Head | Tail], [{Head, Count} | AccTail]) -> 
    count_dups(Tail, [{Head, Count + 1} | AccTail]);
count_dups([H|T], Acc) -> 
    count_dups(T, [{H,1} | Acc]).

% List of all functions (sorted by name) from all loaded modules
loaf() ->
    Mods = code:all_loaded(),
    Funcs = lists:flatten(
	      lists:map(fun({Mod,_FileName}) -> 
		      [ _H1, {exports, ExportedFuncs} | _Tail ] = Mod:module_info(),
		      [ FuncName || {FuncName, _Arity} <- ExportedFuncs ]
	      end, Mods)
	     ),
    lists:sort(Funcs).

% Get the list of functions sorted by their 'popularity' (by name among modules)
loafwc(Direction) ->
    L = count_dups(loaf()),
    OrdFun = case Direction of 
		 up -> fun( {_F1, C1}, {_F2, C2} ) -> C1 =< C2 end;
		 dn -> fun( {_F1, C1}, {_F2, C2} ) -> C1 > C2 end
	     end,
    lists:sort( OrdFun, L ).

test() ->
    io:format("Module exporting most functions: ~p~n", [metmf()]),
    io:format("Most common function name: ~p~n", [mcfn()]),
    io:format("Name of functions used in one module only: ~p~n", [aufn()]).
