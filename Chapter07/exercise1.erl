-module(exercise1).
-export([reverse/1]).

reverse([One]) ->
    [One];
reverse([Head|Tail]) ->
    reverse(Tail) ++ [Head].

