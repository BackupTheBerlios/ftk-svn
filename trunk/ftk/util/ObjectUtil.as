
import ftk.util.StringUtil;
import ftk.core.error.RecursionLimitError;

/**
 * ObjectUtil supplies some static methods for general object handling.
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
 
class ftk.util.ObjectUtil
{
	/**
	 * this property sets the recursion limit for {@see dump}.
	 * Recursion limit is needed to detect recursive references.
	 * If you are sure you don't have any in your objects you
	 * can set it higher. 
	 * You can set the limit to unlimited with the value -1.
	 * Defaul is 255.
	 */
	static public var dumpRecursionLimit:Number = 255;

	/**
	 * detects whether obj is empty or not.
	 * 
	 * @param	obj object to check
	 * @return 	true if object is not empty, false otherwise
	 */
	public static function hasValues(obj:Object):Boolean
	{
		var i:String;
		for( i in obj )
		{
			return true;
		}
		return false;
	}

	/**
	 * count the properties in an object
	 * 
	 * @param	obj object to count
	 * @return 	length of object
	 */
	public static function getLength(obj:Object):Number
	{
		var len:Number = 0;
		var i:String;
		for(i in obj)
		{
			len++;
		}
		return len;
	}

	/**
	 * compares two object's contents.
	 * 
	 * @param 	objA first object to compare
	 * @param 	objB second object to compare
	 * @return 	true if both has same contents, else false
	 */
	public static function compare(objA:Object, objB:Object):Boolean
	{
		var i:String;
		for(i in objA)
		{
			if(objA[i] instanceof Object)
			{
				if(typeof(objA[i]) != typeof(objB[i]))
				{
					return false;
				}
			}
			else if(objA[i] != objB[i])
			{
				return false
			}
			if(hasValues(objA[i]))
			{
				if(!compare(objA[i], objB[i]))
				{
					return false;
				}
			}
		}
		return true;
	}
	
	/**
	 * 
	 * @param	obj
	 * @param	properties
	 * @param	flag
	 */
	static public function setEnumerable(obj, properties, flag:Boolean)
	{
		_global.ASSetPropFlags(obj,properties, flag ? 0 : 1,true);
	}
	
	/**
	 * dump an visual object representation. the dump will be trace'd
	 * as long you don't set the second parameter to true.
	 * 
	 * @param 	myObj object to dump
	 * @param 	returnDump return the dump as an string 
	 * @return 	string if second paramater is true, nothing otherwise
	 */
	public static function dump(myObj):String
	{
		var returnDump:Boolean = Boolean(arguments.length && arguments[1] === true);
		var maxLoops:Number = 500;
		var infiniteLoop:Number = 0;

		var current:Object;
		var obj:Object;
		
		var stack:Array = [{id: 1, obj: myObj, depth: 1}];
		var stackLen:Number = 1;
		
		var output:String = '(' + (myObj instanceof Array ? 'array' : 'object') + ') {\n#{{{-1-}}}#}\n';
		var outputEnd:String;
		var whitespace:String;

		var tmp:Array;
		var i;
		
		if(myObj instanceof XML || myObj instanceof XMLNode)
		{
			output = '(' + (myObj instanceof XML ? 'XML' : 'XMLNode') + ') "' + myObj + '"\n';
			if (!returnDump)
			{
				trace(output);
				return '';
			}
			return output;
		}

		if( ! ObjectUtil.hasValues(myObj) )
		{
			output = '(' + (myObj instanceof Array ? 'array' : typeof(myObj)) + ') "' + myObj + '"\n';
			if (!returnDump)
			{
				trace(output);
				return '';
			}
			return output;
		}

		while(current = stack.pop())
		{
			obj = current.obj;
			
			whitespace = StringUtil.repeat('\t', current.depth);
			
			if(current.id)
			{
				tmp       = output.split('#{{{-' + current.id + '-}}}#');
				output    = tmp[0];
				outputEnd = tmp[1];
			}
			for (i in obj)
			{
				if (dumpRecursionLimit != -1)
				{
					if (++infiniteLoop > dumpRecursionLimit)
					{
						throw new RecursionLimitError("Recursion limit ("+dumpRecursionLimit+") reached. This may be caused by recursive references.");
					}
				}
				if (obj[i] instanceof XML || obj[i] instanceof XMLNode)
				{
					var type:String = (obj[i] instanceof XML) ? 'XML' : 'XMLNode';
					output += whitespace + '[' + i + '] => (' + type + ')' +  ' {\n' 
							 + whitespace + whitespace + obj[i].toString() + "\n" + whitespace + '}\n';
					current.id = null;
					break;
				}
				else if( (obj[i] instanceof Object && ObjectUtil.hasValues(obj[i])) 
					||
					(obj[i] instanceof Array && obj[i].length) )
				{
					var type:String = (obj[i] instanceof Array) ? 'array' : 'object';
					stackLen++;
					output += whitespace + '[' + i + '] => (' + type + ') {\n'
						   +  '#{{{-' + stackLen + '-}}}#' + whitespace + '}\n';
					stack.push({obj: obj[i], id: stackLen, depth: current.depth+1});
				}
				else if(obj == null)
				{
					output += whitespace + '[' + i + '] => (null)\n';
				}
				else
				{
					output += whitespace + '[' + i + '] => (' + typeof(obj[i]) + ') "' + obj[i] + '"\n';
				}
			}
			if (current.id)
			{
				output += outputEnd;
			}
		}
		if (!returnDump)
		{
			trace(output);
			return '';
		}
		return output;
	}
	
	/**
	 * private constructor
	 */
	private function ObjectUtil()
	{
	}
		
}
