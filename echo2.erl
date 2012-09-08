-module(echo2).
-export([start/0, print/1, stop/0, loop/0]).

%function start
start() ->

  case whereis(db_server) of

	  undefined ->
	    Pid = spawn(echo2, loop, []),
      register(echo2, Pid),
      {ok Pid},

  receive
    {_Pid, Msg} -> io:format("~w~n", [Msg])
  end.


    Pid when is_pid(Pid) ->
      {error, already_started}
  end.

%function stop
stop() -> 

  case whereis(echo2) of

    undefined ->
      {error, process_not_found};

    Pid when is_pid(Pid) ->
      Pid ! stop,
      ok
  end.

%function print
print(Msg) ->
  
  case whereis(echo2) of

    undefined ->
      {error, process_not_found};

    Pid when is_pid(Pid) ->
      Pid ! {self(), Msg},
      ok
  end.

%function loop
loop() ->

  receive

    {From, Msg} ->
      From ! {self(), Msg},
      loop();

    stop -> true

   end. 
























