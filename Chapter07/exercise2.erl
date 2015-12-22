-module(exercise2).
-export([term_to_packet/1]).

term_to_packet(Term) ->
    Value = term_to_binary(Term),
    N = byte_size(Value),
    <<N:32, Value:N/binary>>.
