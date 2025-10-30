-module(greet_handler).
-export([init/2]).

init(Req, State) ->
    Name = cowboy_req:binding(name, Req),
    Message = <<"Hello, ", Name/binary, "!">>,
    Req2 = cowboy_req:reply(200, 
        #{<<"content-type">> => <<"text/plain">>}, 
        Message, 
        Req),
    {ok, Req2, State}.