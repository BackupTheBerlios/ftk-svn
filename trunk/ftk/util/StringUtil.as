
/**
 * StringUtil provides methods for string processing.
 *
 * @author patrick müller (elias)
 */

class ftk.util.StringUtil
{
	/**
	 * private constructor!
	 *
	 * @author patrick müller (elias)
	 */
	private function StringUtil(){}
	
	/**
	 * appends 'rep' 'n' times to left side of 'str'
	 *
	 * @param str string to extend
	 * @param rep string to repeat
	 * @param n   repetition of 'rep'
	 * @return padded string
	 */
	public static function padLeft( str:String, rep:String, n:Number ):String
	{
		return repeat(rep, n) + str;
	}

	/**
	 * appends 'rep' 'n' times to right side of 'str'
	 *
	 * @param str string to extend
	 * @param rep string to repeat
	 * @param n   repetition of 'rep'
	 * @return padded string
	 */
	public static function padRight( str:String, rep:String, n:Number ):String
	{
		return str + repeat(rep, n);
	}
	
	/**
	 * repeats 'rep' 'n' times
	 *
	 * @param rep string to repeat
	 * @param n   repetition of 'rep'
	 * @return repeated string
	 */
	public static function repeat( rep:String, n:Number ):String
	{
		var ret:String = '';
		
		while( n-- ) ret += rep;
		
		return ret;
	}
	
	/**
	 * deletes 'chars' on right side
	 *
	 * default chars: '\n\r\t '
	 *
	 * @param str string to trim
	 * @param chars (optional) chars to remove
	 * @return cleaned string
	 */
	public static function trimRight( str:String, chars:String ):String
	{
		if (chars == null)
		{
			chars = '\n\r\t ';
		}
		while( chars.indexOf(str.substr(str.length -1)) > - 1 )
			str = str.substring(0, str.length -1);

		return str;
	}
	
	/**
	 * deletes 'chars' on left side
	 *
	 * default chars: '\n\r\t '
	 *
	 * @param str string to trim
	 * @param chars (optional) chars to remove
	 * @return cleaned string
	 */
	public static function trimLeft( str:String, chars:String ):String
	{
		if (chars == null)
		{
			chars = '\n\r\t ';
		}
		while( chars.indexOf(str.substr(0, 1)) > - 1 )
			str = str.substr(1);
		
		return str;
	}
	
	/**
	 * deletes 'chars' on both sides
	 *
	 * default chars: '\n\r\t '
	 *
	 * @param str string to trim
	 * @param chars (optional) chars to remove
	 * @return cleaned string
	 */
	public static function trim( str:String, chars:String ):String
	{
		if (chars == null)
		{
			chars = '\n\r\t ';
		}
		
		return trimLeft(trimRight(str, chars), chars);
	}
	
	/**
	 * verify that 'str' begins with 'needle'
	 *
	 * @param str string to verify
	 * @param needle beginning string
	 * @return bool
	 */
	public static function startsWith( str:String, needle:String ):Boolean
	{
		if ( str.length < needle.length || str.length <= 0 || needle.length <= 0)
			return false;
		
		if (str.length != needle.length)
			str = str.substring(0, needle.length)
			
		if (  str == needle )
			return true;
			
		return false;
	}
	
	/**
	 * verify that 'str' ends with 'needle'
	 *
	 * @param str string to verify
	 * @param needle ending string
	 * @return bool
	 */
	public static function endsWith( str:String, needle:String ):Boolean
	{
		if ( str.length < needle.length || str.length <= 0 || needle.length <= 0)
			return false;
		
		if (str.length != needle.length)
			str = str.substr(-needle.length)
		
		if (  str == needle )
			return true;
			
		return false;
	}
		
}
