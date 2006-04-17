
/**
 * Command Class
 *
 * @author patrick müller (elias)
 */
class ftk.util.Callback
{
	public static function create(obj:Object, func:Function):Function
	{
		return (new Callback(obj, func)).execute.apply(null , arguments);
	}
	
	private var o: Object;
	private var f: Function;
	private var a: Array;
	
	public function Callback(obj:Object, func:Function)
	{
		o = obj;
		a = arguments.slice( 2 );
		f = func;
	}

	public function execute()
	{
		return (arguments.length ? f.apply(o , arguments) : f.apply( o , a ));
	}
}