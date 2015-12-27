-module(exercise5).
-compile(export_all).

%% Write a function to reverse the bits in a binary.

invert_bits(Binary) -> 
    invert_bits(Binary, <<>>).

invert_bits(<<>>, Acc) -> 
    Acc;
invert_bits(<<BinaryHead:1, BinaryTail/bits>>, Acc) ->
    %% For more details about Erlang bit syntax go: 
    %% http://www.erlang.org/doc/reference_manual/expressions.html#bit_syntax
    invert_bits(<<BinaryTail/bits>>, <<BinaryHead:1, Acc/bits>>).
