
import ftk.util.Debug;

class Main
{
	static function main()
	{
		Debug.init();
		try {
			start();
		} catch(e:Error) {
			trace(e.toString());
		}
	}
	
	static function start()
	{
		var dummy = new example.serialization.PHPSerialize();
		//~ var dummy = new example.io.HttpRequestPlainText();
		//~ var dummy = new example.io.HttpRequestPHPSerialized();
		//~ var dummy = new example.net.BufferedSocketExample();
		//~ var dummy = new example.net.SocketExample();
	}
		
}
