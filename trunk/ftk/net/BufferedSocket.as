
import ftk.util.Delegate;
import ftk.net.Socket;

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

class ftk.net.BufferedSocket extends Socket
{
	private var buffer:Array;

	/**
	 * 
	 * @todo		add buffer size
	 */
	public function BufferedSocket()
	{
		super();
		clearBuffer();
	}
	
	public function connect(host:String, port:Number, timeout:Number):Boolean
	{
		var ret:Boolean = super.connect(host, port, timeout);
		socket.onConnect = Delegate.create(this, notifyConnect);
		return ret;
	}
	
	/**
	 * send data through the socket. if the socket is not connected
	 * the data will pushed into the buffer.
	 *
	 * @param	data string data to send
	 */
	public function send(data:String):Void
	{
		if (isConnected())
			super.send(data);
		else
			buffer.push(data);
	}

	/**
	 * send the buffered messages to the socket and empties the buffer.
	 */
	public function flushBuffer()
	{
		for (var i:Number = 0; i < buffer.length; i++)
		{
			super.send(buffer[i]);
		}
		clearBuffer();
	}
	
	public function clearBuffer()
	{
		buffer = new Array();
	}
	
	private function notifyConnect(success)
	{
		clearTimeoutInterval();
		connected = success;
		if (connected)
		{
			flushBuffer();
			onConnect();
			return;
		}
		onFailure();
	}
	
}
