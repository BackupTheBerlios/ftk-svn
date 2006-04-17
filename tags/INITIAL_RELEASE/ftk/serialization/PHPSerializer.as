
import ftk.serialization.Serializer;
import ftk.serialization.SerializationError;
import ftk.core.error.RecursionLimitError;
import ftk.util.ObjectUtil;

/**
 * PHPSerializer is the equivalent to PHP's serialize()
 * function. it build's a human readable string
 * from flash object's and preserves datatypes/structure.
 *
 * Usage:
 * <code>
 * var serializer:Serializer = new PHPSerializer();
 * var str:String = serializer.serialize(aObject);
 * </code>
 * 
 * The serializer is not able to handle recursive references. See {@recursionLimit}
 * for more details.
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

class ftk.serialization.PHPSerializer
	implements Serializer
{
	/**
	 * Recursion limit is needed to detect recusive references.
	 * If you are sure you don't have any in your objects you
	 * can set it higher. 
	 * You can set the limit to unlimited with the value -1.
	 * Defaul is 255.
	 */
	public var recursionLimit:Number = 255;
	
	private var stack:Array;
	private var stackIndex:Number;
	private var output:String;
	private var outputEnd:String;
	
	/**
	 * constructor
	 */
 	public function PHPSerializer()
	{
	}
	
	/**
	 * creates a string from an object, readable for PHP's unserialize.
	 *
	 * @param obj Object to serialize
	 * @return serialized string
	 * @throws SerializationError if recursive references exceed recursionLimit
	 */
	public function serialize(obj):String
	{
		var infiniteLoop:Number = 0;
		var current:Object;
		var tmp:Array;
		var i;
		
		stack      = [{id: false, obj: obj}];
		stackIndex = 1;
		output     = '';
		
		if(! ObjectUtil.hasValues(obj))
		{
			if(obj instanceof Array)
				writeArray(obj, '');
			else if(obj instanceof Object)
				writeObject(obj, '');
			else
				writeValue(obj);
				
			return output;
		}
		if (obj instanceof XMLNode || obj instanceof XML)
		{
			writeValue(obj);
			return output;
		}
		output  = (obj instanceof Array) ? 'a' : 'O:8:"stdClass"';
		output += ':' + ObjectUtil.getLength(obj) + ':{';

		while(current = stack.pop())
		{
			if (recursionLimit != -1)
			{
				if (++infiniteLoop > recursionLimit)
				{
					throw new RecursionLimitError("*Recursion limit (" + recursionLimit + ") reached! This may be caused by recursive references.");
				}
			}
			obj = current.obj;
			
			if(current.id)
			{
				tmp       = output.split('#{{{-' + current.id + '-}}}#');
				output    = tmp[0];
				outputEnd = tmp[1];
			}
			for (i in obj)
			{
				if (i == int(i))
				{
					writeInteger(int(i));
				}
				else
				{
					writeString(i);
				}
				
				writeValue(obj[i]);
			}
			if (current.id)
			{
				output += outputEnd;
			}
		}

		return String(output + '}');
	}

	/**
	 * detects the type of obj and writes
	 * the serilized contents to output
	 * 
	 * @param obj Object to serialize
	 * @return nothing
	 */
	private function writeValue(obj):Void
	{
		switch(typeof(obj))
		{
		case 'XMLNode':
		case 'XML':
			writeString(obj.toString());
		break;
		case 'object':
			//~ trace([obj, typeof(obj)]);
			if (obj instanceof XML || obj instanceof XMLNode)
			{
				writeString(obj.toString());
				return;
			}
			else if(obj instanceof Array)
			{
				writeArray(obj, '#{{{-' + stackIndex + '-}}}#');
			}
			else
			{
				writeObject(obj, '#{{{-' + stackIndex + '-}}}#');
			}

			stack.push( {obj: obj, id: stackIndex} );
			stackIndex++;
		break;
		
		case 'string':
			writeString(obj);
		break;
		
		case 'number':
			if(Math.abs(obj) % 1 > 0)
				writeFloat(obj);
			else
				writeInteger(obj);
		break;
		
		case 'boolean':
			writeBoolean(obj);
		break;
		
		default:
			writeNull();
		}
	}

	/**
	 * writes serialized object to output
	 * 
	 * @param obj Object to serialize	 * @param str marker string
	 * @return nothing
	 */
	private function writeObject(obj, str:String):Void
	{
		output += 'O:8:"stdClass":' + ObjectUtil.getLength(obj) + ':{' + str + '}';
	}

	/**
	 * writes serialized array to output
	 * 
	 * @param obj array to serialize
	 * @param str marker string
	 * @return nothing
	 */
	private function writeArray(obj, str:String):Void
	{
		output += 'a:' + ObjectUtil.getLength(obj) + ':{' + str + '}';
	}

	/**
	 * writes serialized string to output
	 * 
	 * @param str string to serialize
	 * @return nothing
	 */
	private function writeString(str:String):Void
	{
		output += 's:' + str.length + ':"' + str + '";';
	}
	
	/**
	 * writes serialized integer to output
	 * 
	 * @param n number to serialize
	 * @return nothing
	 */
	private function writeInteger(n:Number):Void
	{
		output += 'i:' + n + ';';
	}

	/**
	 * writes serialized float to output
	 * 
	 * @param n number to serialize
	 * @return nothing
	 */
	private function writeFloat(n:Number):Void
	{
		output += 'd:' + n + ';';
	}
	
	/**
	 * writes serialized boolean to output
	 * 
	 * @param b boolean to serialize
	 * @return nothing
	 */
	private function writeBoolean(b:Boolean):Void
	{
		output += 'b:' + int(b) + ';';
	}
	
	/**
	 * writes serialized NULL to output
	 * 
	 * @return nothing
	 */
	private function writeNull():Void
	{
		output += 'N;';
	}

	/**
	 * toString method
	 * @return String
	 */
	public function toString():String
	{
		return '[Serializer]';
	}
}
