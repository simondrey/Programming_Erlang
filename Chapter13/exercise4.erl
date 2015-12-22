-module(exercise4).
-compile(export_all).

worker() ->
    receive
	stop ->
	    io:format("Worker: I have 'stop' message. Goodbye!~n")
    after 
	1000 ->
	    io:format("Worker: I'm busy...~n"),
	    worker()
    end.

supervisor() ->
    {Worker_Pid, _Worker_Ref} = spawn_monitor(exercise4, worker, []),
    register(worker, Worker_Pid),
    supervisor_loop().

supervisor_loop() ->
    receive
	{'DOWN', _Ref, process, _Pid, _Why} ->
	    io:format("Supervisor: Restarting worker process...~n"),
	    {New_Worker_Pid, _} = spawn_monitor(exercise4, worker, []),
	    % You don't need to unregister(worker), because if process
	    % terminantes for any reason it is automatically unregistered.
	    % However, you need to remember to re-register the worker 
	    % process again to have possibility to send any message to it
	    % using 'worker ! Message.' command.
	    register(worker, New_Worker_Pid),
	    supervisor_loop();
	_AnyOtherMessage ->
	    worker ! stop,
	    io:format("Supervisor: OK, goodbye!~n")
    end.

