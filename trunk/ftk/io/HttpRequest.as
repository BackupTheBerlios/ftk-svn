
//~ import ftk.io.HttpMessage;
import ftk.io.HttpQuery;
import ftk.io.Http;
import ftk.util.Delegate;
import ftk.util.ObjectUtil;
import ftk.io.IoError;
import ftk.serialization.Serializable;

/**
 * http request class
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
 
class ftk.io.HttpRequest
{

	/**
	 * 
	 */
	private var query:HttpQuery;
		
	/**
	 * 
	 */
	private var headers:Object;
		
	/**
	 * 
	 */
	private var url:String;
		
	/**
	 * 
	 */
	private var method:String = 'GET';
		
	/**
	 * 
	 */
	private var timeout:Number = 4000;

	/**
	 * 
	 */
	public var onResponse:Function;

	/**
	 * 
	 */
	public var onFailure:Function;

	/**
	 * 
	 */
	public var onTimeout:Function;

	/**
	 * 
	 * @param 	url  
	 * @param 	method  
	 * @param 	timeout  
	 */
	public function HttpRequest(url:String, method:String, timeout:Number)
	{
		this.url = url;
		if (method != null)
		{
			this.method = method;
		}
		if (timeout != null)
		{
			this.timeout = timeout;
		}
		headers = {};
	}
	
	/**
	 * 
	 * @param 	name  
	 * @param 	value  
	 */
	public function setHeader(name:String, value:String):Void
	{
		headers[name] = value;
	}

	/**
	 * 
	 * @param 	name  
	 * @return 	String
	 */
	public function getHeader(name:String):String
	{
		return headers[name];
	}

	/**
	 * 
	 * @return 	Array
	 */
	public function getHeaders():Array
	{
		var a:Array = [];
		for (var i in headers)
		{
			a.push(i, headers[i]);
		}
		return a;
	}

	/**
	 * 
	 * @param 	data  
	 */
	public function setQueryData(data:Object):Void
	{
		for (var i in data)
			query.setVar(i, data[i]);
	}

	/**
	 * 
	 * @param 	msg
	 */
	public function send(requestMessage:Serializable):Void
	{
		var lv:LoadVars = new LoadVars();
		lv.addRequestHeader(getHeaders());
		lv.data = requestMessage.serialize();
		lv.sendAndLoad(url, createTarget(requestMessage), method);
	}

	/**
	 * 
	 * @return 	String
	 */
	public function toString():String
	{
		return '[HttpRequest]';
	}
	
	/**
	 * 
	 * @return 	Object
	 * @todo		add timeout
	 */
	private function createTarget(requestMsg:Serializable)
	{
		var self:HttpRequest = this;
		var target = {};
		target.onData = function(data)
		{
			if (!data)
			{
				self.onFailure(new IoError("the response body was empty"));
				return;
			}
			//~ ObjectUtil.setEnumerable(target, ['__requesqtMsg'], true);
			//~ ObjectUtil.setEnumerable(target, null, true);
			try {
				self.onResponse(this.__requestMsg.createNew(data));
			} 
			catch (e) {
				self.onFailure(e);
			}
		};
		target.__requestMsg = requestMsg;
		//~ ObjectUtil.setEnumerable(target, ['onData', '__requestMsg'], false);
		return target;
	}

}
