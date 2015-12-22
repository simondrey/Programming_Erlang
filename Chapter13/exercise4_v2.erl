-module(exercise4_v2).
-compile(export_all).

worker() ->
    spawn(fun ->
		 receive
		 after 5000 ->
			 io:format("I'm still running...~n")
		 end
	 end).

