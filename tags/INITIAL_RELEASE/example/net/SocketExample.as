
import ftk.util.Delegate;
import ftk.net.Socket;

class example.net.SocketExample
{
	private var socket:Socket;
	private var interval:Number;
	private var i:Number;
		
	function SocketExample()
	{
		trace('start...');
		socket = new Socket();
		socket.onConnect = Delegate.create(this, onConnect);
		socket.onFailure = Delegate.create(this, onFailure);
		socket.onTimeout = Delegate.create(this, onTimeout);
		socket.onClose = Delegate.create(this, onClose);
		socket.onData = Delegate.create(this, onData);
		socket.connect('127.0.0.1', 12345);
	}
	
	function onConnect()
	{
		trace('connected');
		for (var i:Number = 0; i < 10; i++)
			socket.send('msg-'+i);
	}
	
	function onData(d)
	{
		trace('data: ' + d);
	}

	function onFailure()
	{
		trace('failure');
	}
	
	function onTimeout()
	{
		trace('timeout');
	}
	
	function onClose()
	{
		trace('close');
	}

}
