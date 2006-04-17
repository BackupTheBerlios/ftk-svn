
import ftk.net.BufferedSocket;

class example.net.BufferedSocketExample
{
	function BufferedSocketExample()
	{
		trace('start...');
		var socket:BufferedSocket = new BufferedSocket('127.0.0.1', 12345);
		socket.onConnect = function()
		{
			trace('connected');
		}
		socket.onFailure = function()
		{
			trace('failure');
		}
		socket.onTimeout = function()
		{
			trace('timeout');
		}
		socket.onClose = function()
		{
			trace('close');
		}
		socket.onData = function(d)
		{
			trace('data: ' + d);
		}
		socket.connect();
		for (var i:Number = 0; i < 10; i++)
			socket.send('msg-'+i);
		//~ socket.close();
	}
}
