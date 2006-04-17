
class ftk.util.Delegate
{
	
	public static function create(o:Object, f:Function):Function
	{
		return function()
		{
			return f.apply(o, arguments);
		};
	}

}
