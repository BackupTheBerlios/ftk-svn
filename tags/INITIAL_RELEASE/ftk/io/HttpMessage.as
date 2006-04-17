
import ftk.serialization.Serializable;
import ftk.serialization.Serializer;
import ftk.serialization.Deserializer;
import ftk.serialization.NullSerializer;
import ftk.serialization.NullDeserializer;

/**
 * http message class
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

class ftk.io.HttpMessage implements Serializable
{

	/**
	 * 
	 */
	private var serializer:Serializer;

	/**
	 * 
	 */
	private var deserializer:Deserializer;

	/**
	 * 
	 */
	private var body:Object;

	/**
	 * 
	 * @param 	serializer  
	 * @param 	deserializer  
	 */
	public function HttpMessage(serializer:Serializer, deserializer:Deserializer)
	{
		this.serializer = !serializer ? new NullSerializer() : serializer;
		this.deserializer = !deserializer ? new NullDeserializer() : deserializer;
		body = null;
	}

	/**
	 * 
	 * @param 	obj  	 */
	public function setBody(obj:Object):Void
	{
		body = obj;
	}

	/**
	 * 
	 * @return 	Object
	 */
	public function getBody():Object
	{
		return body;
	}

	/**
	 * 
	 * @return 	Message
	 * @throws 	SerializationError
	 */
	public function createNew(data:String):Serializable
	{
		var msg:Serializable = new HttpMessage(serializer, deserializer);
		msg.deserialize(data);
		return msg;
	}
	
	/**
	 * 
	 * @return 	String
	 */
	public function serialize():String
	{
		return serializer.serialize(body);
	}

	/**
	 * 
	 * @param 	serialized  
	 */
	public function deserialize(serialized:String):Void
	{
		body = deserializer.deserialize(serialized);
	}

	/**
	 * 
	 * @return 	String
	 */
	public function toString():String
	{
		return '[HttpMessage]';
	}

}
