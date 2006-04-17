
import ftk.core.Null;
import ftk.serialization.Deserializer;

/**
 * Null object for Serializer interface.
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

class ftk.serialization.NullDeserializer
	implements Deserializer, Null
{
	
	public function deserialize(data):String
	{
		return data.toString();
	}
	
	public function isNull():Boolean
	{
		return true;
	}
	
	
}
