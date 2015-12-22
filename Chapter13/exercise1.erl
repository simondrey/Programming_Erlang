-module(exercise1).
-export([my_spawn/3, sleep/1]).

%% Write a function my_spawn(Mod, Func, Args) that behaves like spawn(Mod, Func, Args) but with one difference. If the spawned process dies, a message should be printed saying why the process died and how long the process lived for before it died.

sleep(Time) ->
    receive
    after Time ->
	true
    end.

my_spawn(Mod, Func, Args) ->
    T1 = erlang:timestamp(),
    {Pid,Ref} = spawn_monitor(Mod, Func, Args),
    receive 
	{'DOWN',_Ref,process,Pid,Why} ->
	    T2 = erlang:timestamp(),
	    io:format("Process ~p died, Reason is '~p'.~n", [Pid, Why]),
	    io:format("Time = ~p~n", [timer:now_diff(T2, T1)/1000/1000])
    end.
