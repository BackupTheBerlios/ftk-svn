
import asunit.framework.*;
import ftk.serialization.PHPSerializer;
import ftk.core.error.RecursionLimitError;

class test.ftk.serialization.PHPSerializerTest extends TestCase
{
	private var ser:PHPSerializer;
	
	public function PHPSerializerTest()
	{
	}
	
	public function setUp():Void
	{
		ser = new PHPSerializer();
	}

	public function tearDown():Void
	{
		delete ser;
	}

	public function testNull():Void
	{
		assertRoundtripSerializeSame(null, 'N;');
		assertRoundtripSerializeSame(
			[undefined],
			'a:1:{i:0;N;}'
		);
		assertRoundtripSerializeSame(
			{test:undefined},
			'O:8:"stdClass":1:{s:4:"test";N;}'
		);
	}
	
	public function testInteger():Void
	{
		assertRoundtripSerializeSame(
			23,
			'i:23;'
		);
		assertRoundtripSerializeSame(
			[23],
			'a:1:{i:0;i:23;}'
		);
		assertRoundtripSerializeSame(
			{test:23},
			'O:8:"stdClass":1:{s:4:"test";i:23;}'
		);
	}

	public function testFloat():Void
	{
		assertRoundtripSerializeSame(
			23.23,
			'd:23.23;'
		);
		
		assertRoundtripSerializeSame(
			[23.23],
			'a:1:{i:0;d:23.23;}'
		);
		assertRoundtripSerializeSame(
			{test:23.23},
			'O:8:"stdClass":1:{s:4:"test";d:23.23;}'
		);
	}

	public function testBoolean():Void
	{
		assertRoundtripSerializeSame(
			true,
			'b:1;'
		);
		assertRoundtripSerializeSame(
			[true],
			'a:1:{i:0;b:1;}'
		);
		assertRoundtripSerializeSame(
			{test:true},
			'O:8:"stdClass":1:{s:4:"test";b:1;}'
		);
	}
	
	public function testEmptyString():Void
	{
		assertRoundtripSerializeSame(
			"",
			's:0:"";'
		);
	}
	
	public function testString():Void
	{
		assertRoundtripSerializeSame(
			"test",
			's:4:"test";'
		);
		assertRoundtripSerializeSame(
			["foo"],
			'a:1:{i:0;s:3:"foo";}'
		);
		assertRoundtripSerializeSame(
			{test:"foo"},
			'O:8:"stdClass":1:{s:4:"test";s:3:"foo";}'
		);
	}
	
	public function testQuotedString():Void
	{
		assertRoundtripSerializeSame(
			"attribute=\"foo\"",
			's:15:"attribute="foo"";'
		);
		assertRoundtripSerializeSame(
			"attribute=\\\"foo\\\"",
			's:17:"attribute=\\"foo\\"";'
		);
	}
	
	public function testArrayEmpty():Void
	{
		assertRoundtripSerializeSame(
			[],
			'a:0:{}'
		);
	}
	
	public function testObjectEmpty():Void
	{
		assertRoundtripSerializeSame(
			{},
			'O:8:"stdClass":0:{}'
		);
	}

	public function testArrayAll():Void
	{
		var obj:Object;
		var str:String;
		
		obj = [1,2,3];
		obj.undef = undefined;
		obj.bool = false;
		obj.key = 'value';
		obj.num = 23;
		obj.float = 23.23;
		obj.obj = {};		

		str = 'a:9:{s:3:"obj";O:8:"stdClass":0:{}s:5:"float";d:23.23;s:3:"num";i:23;s:3:"key";s:5:"value";s:4:"bool";b:0;s:5:"undef";N;i:2;i:3;i:1;i:2;i:0;i:1;}';
		
		assertRoundtripSerializeSame(
			obj,
			str
		);
	}

	public function testObjectAll():Void
	{
		var str:String;
		var obj:Object;
		
		str = 'O:8:"stdClass":5:{s:3:"arr";a:3:{i:2;i:3;i:1;i:2;i:0;i:1;}s:5:"undef";N;s:4:"bool";b:1;s:4:"hash";O:8:"stdClass":1:{s:3:"key";s:5:"value";}s:5:"float";d:23.23;}';
		
		obj = {arr:[1,2,3],undef: undefined, bool:true, hash:{key:'value'}, float:23.23};	
		//~ str = ser.serialize(obj);
		
		assertRoundtripSerializeSame(
			obj,
			str
		);
	}
	
	public function testXML():Void
	{
		assertRoundtripSerializeSame(
			new XML("<test>blah</test>"),
			's:17:"<test>blah</test>";'
		);
	}
	
	public function testNestedXML():Void
	{
		assertRoundtripSerializeSame(
			[new XML("<test>blah</test>")],
			'a:1:{i:0;s:17:"<test>blah</test>";}'
		);
	}
	
	public function testRecursion():Void
	{
		var arr = new Array();
		arr[0] = arr;
		try {
			ser.serialize(arr)
		} catch (e:RecursionLimitError) {
			assertTrue('', true);
			return;
		}
		assertTrue('recursion does not throw RecursionLimitError', false);
	}

	private function assertRoundtripSerializeSame(obj, assertion:String)
	{
		var res:String = ser.serialize(obj);
		assertSame(
			assertion + " !== " + res,
			assertion,
			res
		);
	}
	
}
