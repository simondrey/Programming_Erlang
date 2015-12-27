-module(exercise4).
-compile(export_all).

%% Write some tests in the style of Adding Tests to Your Code,on page 46, to test that the previous two functions can correctly encode terms into packets and recover the original terms by decoding the packets.

-import(exercise3, [term_to_packet/1, packet_to_term/1]).

test() ->
    test(ok).
test(Term) ->
    Term = packet_to_term(term_to_packet(Term)),
    test_worked.
