
import ftk.util.Delegate;

/**
 * A better socket implementation on top of XMLSocket
 * 
 * @author     Patrick Müller <elias{edd}adaptiveinstance{dod}com>
 * @copyright  Patrick Müller 2006
 * @license    http://www.opensource.org/licenses/lgpl-license.php  LGPL
 * @see        http://adaptiveinstance.com
 * @see        http://developer.berlios.de/projects/ftk/
 * @since      0.10
 * @version    SVN: $Id$
 * @version    Release: @package_version@
 */

class ftk.net.Socket
{
	private var socket:XMLSocket;
	private var timeoutInterval:Number = null;
	private var connected:Boolean = false;
		
	public var onConnect:Function;
	public var onData:Function;
	public var onClose:Function;
	public var onFailure:Function;
	public var onTimeout:Function;
	
	public function Socket()
	{
		socket = new XMLSocket;
	}
	
	/**
	 * @param 	host
	 * @param 	port
	 * @param 	timeout timeout in milliseconds (default 4000)
	 * @return 	true if connection is possible, false otherwise 
	 */
	public function connect(host:String, port:Number, timeout:Number):Boolean
	{
		if (!timeout)
		{
			timeout = 4000;
		}
		connected = false;
		if (onConnect)
			socket.onConnect = Delegate.create(this, notifyConnect);
		if (onData)
			socket.onData = Delegate.create(this, onData);
		timeoutInterval = setInterval(Delegate.create(this, notifyTimeout), timeout);
		return socket.connect(host, port);
	}
	
	/**
	 * 
	 * @return	true if socket is connected, false otherwise
	 */
	public function isConnected():Boolean
	{
		return connected;
	}
	
	/**
	 * 
	 * @param	data string data to send
	 */
	public function send(data:String):Void
	{
		socket.send(data);
	}
		
	/**
	 * close the socket connection
	 */
	public function close()
	{
		clearTimeoutInterval();
		connected = false;
		socket.close();
	}
	
	private function notifyTimeout()
	{
		close();
		onTimeout();
	}
	
	private function notifyConnect(success)
	{
		clearTimeoutInterval();
		connected = success;
		if (connected)
		{
			onConnect();
			return;
		}
		onFailure();
	}
	
	private function clearTimeoutInterval()
	{
		if (timeoutInterval !== null)
		{
			clearInterval(timeoutInterval);
		}
		timeoutInterval = null;
	}
	
}
