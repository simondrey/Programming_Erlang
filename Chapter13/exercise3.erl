-module(exercise3).
-compile(export_all).

do_delayed(Time, Fun) when is_function(Fun) ->
    spawn(fun() ->
		  receive
		  after Time ->
			  Fun(),
			  io:format("Delayed job is done.~n")
		  end 
	  end).

my_spawn(Mod, Func, Args, Time) ->
    Pid = spawn(Mod, Func, Args),
    do_delayed(Time, fun() -> exit(Pid, kill) end).

my_spawn2(Mod, Func, Args, Time) ->
    Pid = spawn(Mod, Func, Args),
    spawn(fun() ->
		  receive
		  after Time ->
			  exit(Pid, kill), 
			  io:format("Delayed job is done.~n")
		  end
	  end).

loop() ->
    receive
    after 1000 ->
	    io:format("loop() is alive...~n"),
	    loop()
    end.

test() ->
    io:format("I am starting a new process, after 5 secs it should be killed~n"),
    my_spawn(exercise3, loop, [], 5000),
    io:format("Done.~n").

test2() ->
    io:format("I am starting a new process, after 5 secs it should be killed~n"),
    my_spawn2(exercise3, loop, [], 5000),
    io:format("Done.~n").



    
    
