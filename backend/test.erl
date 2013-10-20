-module(test).

-include("include/amqp_client.hrl").
-export([main/0]).

main()->
	%%you could change the host address to your own server`s address
	case amqp_connection:start(#amqp_params_network{host = "130.238.15.222"}) of
		{ok, Connection}->
			%%the connection succeeds
			case amqp_connection:open_channel(Connection) of
				{ok, Channel}->
					%%succeeds opening the channel
					%%you could change the content of the message to your own message
					Message = <<"erlang succeeds">>,
					Publish = #'basic.publish'{	exchange = <<"amq.topic">>,
												routing_key = <<"mymessages">> },
					amqp_channel:cast(Channel, Publish, #amqp_msg{payload = Message});
				{error, ErrMsg}->
					erlang:display(ErrMsg)
				end;
		{error, ErrMsg}->
			erlang:display(ErrMsg)
		end.
