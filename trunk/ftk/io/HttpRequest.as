
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
 *
 * @todo	timeout
 * @todo	query vars
 * @todo	GET
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
	 * @throws 	IoError
	 */
	public function send(requestMessage:Serializable):Void
	{
		var lv:LoadVars = new LoadVars();
		lv.addRequestHeader(getHeaders());
		lv.data = requestMessage.serialize();
		if (!lv.sendAndLoad(url, createTarget(requestMessage), method))
		{
			throw new IoError("Cannot send message! Is the URL ("+url+") and method valid?");
		}
	}

	/**
	 * 
	 * @return 	String
	 */
	public function toString():String
	{
		return '[HttpRequest url="'+url+'" method="'+method+'"]';
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
			//~ trace('data: "'+data+'"');
			if (!data)
			{
				self.onFailure(new IoError("the response body was empty"));
				return;
			}
			try {
				self.onResponse(this.__requestMsg.createNew(data));
			} 
			catch (e) {
				self.onFailure(e);
			}
		};
		target.__requestMsg = requestMsg;
		ObjectUtil.setEnumerable(target, ['onData', '__requestMsg'], false);
		return target;
	}

}
