-module(exercise3).
-export([term_to_packet/1, packet_to_term/1]).

term_to_packet(Term) ->
    Value = term_to_binary(Term),
    N = byte_size(Value),
    <<N:32, Value:N/binary>>.

packet_to_term(Packet) ->
    <<_Header:32, Value:_Header/binary>> = Packet,
    io:format("Value of header is: ~p~n",[_Header]),
    binary_to_term(Value).
