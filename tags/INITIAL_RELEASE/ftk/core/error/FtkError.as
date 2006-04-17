
import ftk.util.Stacktrace;

/**
 * FtkError is the base exception for all ftk exceptions.
 *
 * @author     Patrick Müller <elias{edd}adaptiveinstance{dod}com>
 * @copyright  Patrick Müller 2006
 * @license    http://www.opensource.org/licenses/lgpl-license.php  LGPL
 * @see        http://adaptiveinstance.com
 * @see        http://developer.berlios.de/projects/ftk/
 * @see        Stacktrace
 * @since      0.10
 * @version    SVN: $Id$
 * @version    Release: @package_version@
 */

class ftk.core.error.FtkError extends Error
{
	private var message:String;
	private var code:Number;
	private var stack:Array;
	
	/**
	 * 
	 * @param	msg error message
	 * @param	n error code
	 */
	public function FtkError(msg:String, n:Number)
	{
		message = msg;
		code    = n;
		stack   = Stacktrace.getStack();
	}
	
	/**
	 * 
	 * @return	the stacktrace
	 */
	public function getTrace():Array
	{
		return stack;
	}
	
	/**
	 * 
	 * @return	the error message
	 */
	public function getMessage():String
	{
		return message;
	}
	
	/**
	 * 
	 * @return	the error code
	 */
	public function getCode():Number
	{
		return code;
	}
	
	/**
	 * 
	 * @return	the stacktrace as string
	 */
	public function getTraceAsString():String
	{
		var s:String = '';
		for (var i:Number = 0; i < stack.length; i++)
		{
			var item:Array = stack[i];
			s += '#'+i+' '+item[0]+'.'+item[1]+'('+item[5].length+')\n\t in '+item[2]+', line '+item[3]+'\n';
		}
		return s;
	}

	/**
	 * 
	 * @return	a string representation of this exception
	 */
	function toString():String
	{
		var me:String = 'Error';
		if (stack.length)
		{
			me = stack[stack.length-1][0];
		}
		if (code != null)
		{
			me += '('+code+')';
		}
		//~ trace(me + ' with message: ' + message + "\n"+getTraceAsString());
		return me + ' with message: ' + message + "\n"+getTraceAsString();
	}
}