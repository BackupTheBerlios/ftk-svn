
import ftk.serialization.Deserializer;
import ftk.serialization.SerializationError;
import ftk.core.error.RecursionLimitError;

/**
 * PHPDeserializer is the equivalent to PHP's unserialize()
 * function. it creates flash types and structure from
 * serialized strings.
 *
 * Usage:
 * <code>
 * var deserializer:Deserializer = new PHPDeserializer();
 * var str:String = deserializer.deserialize(aSerializedString);
 * </code>
 * 
 * The deserializer is currently not able to remove escape sequences
 * added by php's magic_quotes. double check that the directive is
 * turned OFF, it is useless at all.
 *
 * @author     Patrick Müller <elias{edd}adaptiveinstance{dod}com>
 * @copyright  Patrick Müller 2006
 * @license    http://www.opensource.org/licenses/lgpl-license.php  LGPL
 * @see        http://adaptiveinstance.com
 * @see        http://developer.berlios.de/projects/ftk/
 * @see        http://php.net/serializer
 * @see        http://php.net/unserializer
 * @since      0.10
 * @version    SVN: $Id$
 * @version    Release: @package_version@
 */

class ftk.serialization.PHPDeserializer
	implements Deserializer
{
	/**
	 * Recursion limit is used to detect broken serialized strings.
	 * You can set the limit to unlimited with the value -1.
	 * Defaul is 255.
	 */
	public var recursionLimit:Number = 255;

	private var ptr:Number;
	private var raw:String;
	private var type:String;	
	private var T_OBJECT:String      = 'O';	private var T_ARRAY:String       = 'a';	private var T_INTEGER:String     = 'i';	private var T_FLOAT:String       = 'd';	private var T_BOOLEAN:String     = 'b';	private var T_STRING:String      = 's';	private var T_UNDEFINED:String   = 'N';	private var T_CURLY_OPEN:String  = '{';	private var T_CURLY_CLOSE:String = '}';
	private var T_SEMICOLON:String   = ';';

	/**
	 * constructor
	 */
 	public function PHPDeserializer()
	{
	}
	
	/**
	 * creates flash object from serialized string.
	 *
	 * @param 	obj String to unserialize
	 * @return 	object
	 * @throws 	SerializationError if string is not deserializable
	 */
	public function deserialize(str:String):Object
	{
		var infiniteLoop:Number = 0;
		
		var depths:Number = 0;
		var key, value;
		ptr = 0;
		raw = str;
		
		value = parseToken();
		if(raw.charAt(raw.length-1) == T_SEMICOLON && raw.charAt(ptr-1) == T_CURLY_CLOSE)
			throw new SerializationError("String does not look like an serialized string or is possibly broken.");
		
		var stack:Array = [value];

		while(ptr < raw.length)
		{
			if (recursionLimit != -1)
			{
				if (++infiniteLoop > recursionLimit)
				{
					throw new RecursionLimitError("Recursion limit (" + recursionLimit + ") reached! The serialized string is possibly broken!");
				}
			}
			
			if(raw.charAt(ptr) == T_CURLY_CLOSE)
			{
				if(++ptr >= raw.length)
					break;

				stack.pop();
				depths--;
				continue;
			}
			
			key   = parseToken();
			value = parseToken();
			
			stack[depths][key] = value;
			
			if(type == T_ARRAY || type == T_OBJECT)
			{
				depths++;
				stack.push(value);
			}
		}
		/*
		trace('----------------------------------------');
		trace('pointer\t:' + ptr);
		trace('length\t: ' + raw.length);
		trace('charAt(ptr)\t: "' + raw.charAt(ptr) + '"');
		trace('raw\t\t: ' + raw);		trace('depths\t: ' + depths);
		trace('stack\t: ' + stack.length);
		*/		return stack[0];
	}

	/**
	 * detects type of token and parses it.
	 *
	 * @return object
	 */
	private function parseToken()
	{
		var value = null;
		type = parseType();
		switch(type)
		{
			case T_UNDEFINED:
				value = undefined;
			break;
			
			case T_STRING:
				value = parseString();
			break;
			
			case T_INTEGER:
				value = parseInteger();
			break;
			
			case T_FLOAT:
				value = parseDigit();
			break;
			
			case T_BOOLEAN:
				value = parseBoolean();
			break;
			
			case T_ARRAY:
				value = parseArray();
			break;
			
			case T_OBJECT:
				value = parseObject();
			break;

			default:
				throw new SerializationError("Type \""+type+"\" unknown or not implemented.");
		}
		return value;
	}

	/**
	 * parse type
	 * @return String
	 */
	private function parseType():String
	{
		var type:String = raw.charAt(ptr);
		ptr += 2;
		return type;
	}

	/**
	 * parse/convert string
	 * @return String
	 */
	private function parseString():String
	{
		var len:Number;
		var str:String;
		var pos:Number;
		var n:Number;
		
		pos = raw.indexOf(':', ptr);
		len = parseInt(raw.substring(ptr, pos), 10);
		ptr = pos + 2;
//		len = parseInt(raw.charAt(ptr), 10);
		str = raw.substr(ptr, len);
		ptr += len + 2;
		//ptr += len + 5;
		
		return str;
	}

	/**
	 * parse/convert integer
	 * @return Number
	 */
	private function parseInteger():Number
	{
		var pos:Number;
		var n:Number;
		
		pos = raw.indexOf(';', ptr);
		n   = parseInt(raw.substring(ptr, pos), 10);
		ptr = pos + 1;
		
		return n;
	}

	/**
	 * parse/convert Float
	 * @return Number
	 */
	private function parseDigit():Number
	{
		var pos:Number;
		var n:Number;
		
		pos = raw.indexOf(';', ptr);
		n   = parseFloat(raw.substring(ptr, pos));
		ptr = pos + 1;

		return n;
	}
	
	/**
	 * parse/convert boolean
	 * @return Boolean
	 */
	private function parseBoolean():Boolean
	{
		var n:Number = int(raw.charAt(ptr));
		ptr += 2;
		return (n ? true : false);
	}

	/**
	 * parse/convert array
	 * @return Array
	 */
	private function parseArray():Array
	{
		ptr = raw.indexOf(T_CURLY_OPEN, ptr) + 1;
		return [];
	}

	/**
	 * parse/convert Object
	 * @return Object
	 */
	private function parseObject():Object
	{
		ptr = raw.indexOf(T_CURLY_OPEN, ptr) + 1;
		return {};
	}
	
	/**
	 * toString method
	 * 
	 * @return String
	 */
	public function toString():String
	{
		return '[PHPDeserializer]';
	}
}
