
/**
 * simple delegate utility.
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
class ftk.util.Delegate
{
	
	/**
	 * 
	 * @param	target
	 * @param	functionInstance
	 * @return	delegated function
	 * @throws	
	 */
	public static function create(target:Object, functionInstance:Function):Function
	{
		return function()
		{
			return functionInstance.apply(target, arguments);
		};
	}

}
