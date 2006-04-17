
import ftk.core.error.FtkError;

/**
 * RecursionLimitError should be thrown if very long loops or deep nesting is
 * detected.
 *
 * @author     Patrick M�ller <elias{edd}adaptiveinstance{dod}com>
 * @copyright  Patrick M�ller 2006
 * @license    http://www.opensource.org/licenses/lgpl-license.php  LGPL
 * @see        http://adaptiveinstance.com
 * @see        http://developer.berlios.de/projects/ftk/
 * @see        Stacktrace
 * @since      0.10
 * @version    SVN: $Id$
 * @version    Release: @package_version@
 */
 
class ftk.core.error.RecursionLimitError extends FtkError
{
	
	public function RecursionLimitError(msg:String, n:Number)
	{
		super(msg, n);
	}

}
