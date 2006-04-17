
import ftk.serialization.Serializer;
import ftk.serialization.Deserializer;
//~ import ftk.serialization.QuerySerializer;
//~ import ftk.serialization.QueryDeserializer;
import ftk.serialization.Serializable;


/**
 * http class
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

class ftk.io.HttpQuery
	implements Serializable
{

	/**
	 * 
	 */
	private var vars:Object = {};

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
	public function HttpQuery()
	{
		//~ serializer = new QuerySerializer();
		//~ deserializer = new QueryDeserializer();
	}
	
	/**
	 * 
	 * @param 	name  
	 * @param 	value  
	 */
	public function setVar(name:String, value:String):Void
	{
		vars[name] = value;
	}

	/**
	 * 
	 * @return 	String
	 */
	public function getVar(name:String):String
	{
		return vars[name];
	}

	/**
	 * 
	 * @return 	String
	 */
	public function serialize():String
	{
		var str:String = '';
		for (var i in vars)
			str += '&' + i + '= ' + vars[i];
		return str;
	}

	/**
	 * 
	 * @param 	serialized  
	 */
	public function deserialize(serialized:String):Void
	{
		vars = {};
		var arr:Array = serialized.split('&');
		for (var i:Number; i < arr.length; i++)
		{
			var pair:Array = arr[i].split('=');
			vars[pair[0]] = pair[1];
		}
	}

	/**
	 * 
	 * @return 	String
	 */
	public function toString():String
	{
		return '[HttpQuery]';
	}

}
