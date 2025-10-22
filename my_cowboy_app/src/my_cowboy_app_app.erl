%%%-------------------------------------------------------------------
%% @doc my_cowboy_app public API
%% @end
%%%-------------------------------------------------------------------

-module(my_cowboy_app_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/", hello_handler, []},
            {"/greet/:name", greet_handler, []}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(http_listener, 
        [{port, 8080}],
        #{env => #{dispatch => Dispatch}}
    ),
    my_cowboy_app_sup:start_link().

stop(_State) ->
    ok = cowboy:stop_listener(http_listener),
    ok.

%% internal functions