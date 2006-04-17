
/**
 * Stacktrace is a class to manage stacktraces supported by hamtasc.
 * You have to point hamtasc to the pop/push methods via compiler flags:
 *	   -rb_auto_trace ftk.util.Stacktrace.push 
 *    -rb_auto_trace_pop ftk.util.Stacktrace.pop
 * 
 * You can receive the current stack via getStack method.
 * If you do not compile with mtasc the push/pop methods are unused
 * and getStack always return an empty array.
 *
 * Keep in mind that the stacktrace is generated at compile time. It will
 * make your movie slower and bigger. Further the traces are done from
 * at every start of an function and not at the point of call.
 *
 * You should not use the push/pop methods at runtime.
 *
 * @author     Patrick Müller <elias{edd}adaptiveinstance{dod}com>
 * @copyright  Patrick Müller 2006
 * @license    http://www.opensource.org/licenses/lgpl-license.php  LGPL
 * @see        http://adaptiveinstance.com
 * @see        http://developer.berlios.de/projects/ftk/
 * @see        http://osflash.org/hamtasc
 * @since      0.10
 * @version    SVN: $Id$
 * @version    Release: @package_version@
 */

class ftk.util.Stacktrace
{

	/**
	 * the stack with the traces
	 */
	private static var stack:Array = [];
	
	/**
	 * push an trace into the stack
	 * @param	className
	 * @param	methodName
	 * @param	file
	 * @param	line
	 * @param	caller
	 * @param	arguments
	 */
	public static function push():Void
	{
		stack.push(arguments);
	}

	/**
	 * pop an trace off the stack. this method do not return the trace.
	 */
	public static function pop():Void
	{
		stack.pop();
	}
	
	/**
	 * return a copy of the stack.
	 * @return	the stack
	 */
	public static function getStack():Array
	{
		return stack.concat();
	}

}
