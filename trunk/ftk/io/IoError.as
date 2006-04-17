
import ftk.core.error.FtkError;

/**
 * base exception for io package
 * 
 * @author     Patrick M�ller <elias{edd}adaptiveinstance{dod}com>
 * @copyright  Patrick M�ller 2006
 * @license    http://www.opensource.org/licenses/lgpl-license.php  LGPL
 * @see        http://adaptiveinstance.com
 * @see        http://developer.berlios.de/projects/ftk/
 * @since      0.10
 * @version    SVN: $Id$
 * @version    Release: @package_version@
 */
class ftk.io.IoError extends FtkError
{
	
	public function IoError(msg:String, n:Number)
	{
		super(msg, n);
	}

}
