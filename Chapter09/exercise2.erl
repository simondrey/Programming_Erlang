-module(exercise2).
-compile(export_all).

%% Look at the type annotations in the code 
%% in the standard libraries. Find the source
%% code for the module lists.erl and read all
%% the type annotations.

%% I was there :-), some 'extract' below:

%% [..]

-spec append(List1, List2) -> List3 when
      List1 :: [T],
      List2 :: [T],
      List3 :: [T],
      T :: term().

append(L1, L2) -> L1 ++ L2.

%% [..]
