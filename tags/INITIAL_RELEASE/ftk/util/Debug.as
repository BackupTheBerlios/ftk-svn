
/**
 * Debug is for internal debugging only. Do not rely on this class for your 
 * production environment.
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
class ftk.util.Debug
{
	
	static private var verboseTrace:Boolean = false;
	static public var output:TextField;
		
	static public function init():Void
	{
		fscommand('fullscreen', true);
		fscommand('allowscale', false);
		Stage.align = 'tl';
		Stage.scaleMode = 'noScale';
		_root.createEmptyMovieClip('__debug', -16677);
		_root.__debug.createTextField('txt', -16667, 0, 0, 600, 600);
		output = _root.__debug.txt;
		with(output)
		{
			border = true;
			wordWrap = true;
			multiline = true;
			_y = _x = 0;
			setNewTextFormat(new TextFormat('Verdana', 11, 0xFF0000));
		}
	}
	
	static public function setVerboseTrace(flag:Boolean):Void
	{
		verboseTrace = flag;
	}
	
	static public function getVerboseTrace():Boolean
	{
		return verboseTrace;
	}
	
	static public function Trace(msg:Object, caller:String, file:String, line:Number):Void
	{
		var str:String = '';
		if (verboseTrace)
			str = "File '"+file+"', line "+line+", in "+caller+"\n\t";
		print(str + msg);
	}
	
	static public function print(s):Void
	{
		output.text += s + '\n';
	}
	
	//~ static public function print(s:String):Void
	//~ {
		//~ output.text += s;
	//~ }
	
	static public function get out():String
	{
		return output.text;
	}
	
	static public function set out(s:String):Void
	{
		output.text += s;
	}
	
	static public function clear():Void
	{
		output.text = '';
	}
	
}
