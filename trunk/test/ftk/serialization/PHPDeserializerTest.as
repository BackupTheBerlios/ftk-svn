

import asunit.framework.*;
import ftk.serialization.PHPDeserializer;
import ftk.util.ObjectUtil;

class test.ftk.serialization.PHPDeserializerTest extends TestCase
{
	private var uns;
	
	public function PHPDeserializerTest()
	{
		//trace('TPHPSerialize.contructor');
	}
	
	public function setUp():Void
	{
		uns = new PHPDeserializer();
	}
	
	public function tearDown():Void
	{
		delete uns;
	}
	
	public function testNull():Void
	{
		assertRoundtripDeserializeEquals(
			'N;',
			undefined
		);
	}
	
	public function testInteger():Void
	{
		assertRoundtripDeserializeEquals(
			'i:23;',
			23
		);
	}

	public function testFloat():Void
	{
		assertRoundtripDeserializeEquals(
			'd:23.230000000000000426325641456060111522674560546875;',
			23.23
		);
	}

	public function testString():Void
	{
		assertRoundtripDeserializeEquals(
			's:4:"test";',
			"test"
		);
	}
	
	public function testLongString():Void
	{
		assertRoundtripDeserializeEquals(
			's:12:"hello world!";',
			"hello world!"
		);
	}

	public function testBoolean():Void
	{
		assertRoundtripDeserializeEquals(
			'b:1;',
			true
		);
	}

	public function testArrayEmpty():Void
	{
		var str:String = 'a:0:{}';
		var obj = uns.deserialize(str);
		
		assertTrue(
			obj + " NOT instanceof Array",
			obj instanceof Array
		);
		assertEquals(
			0 + " !== " + obj.length,
			0,
			obj.length
		);
	}

	public function testObjectEmpty():Void
	{
		var str:String = 'O:8:"stdClass":0:{}';
		var obj = uns.deserialize(str);
		
		assertTrue(
			obj + " NOT instanceof Object",
			obj instanceof Object
		);
		var isEmpty = true;
		for (var i in obj)
		{
			isEmpty = false;
			break;
		}
		assertTrue(
			obj + " is NOT empty ",
			isEmpty
		);
	}
	
	public function testArrayAll():Void
	{
		var str:String = 'a:9:{i:0;i:1;i:1;i:2;i:2;i:3;s:10:"longString";s:12:"hello world!";s:5:"undef";N;s:4:"bool";b:0;s:3:"key";s:5:"value";s:3:"num";i:23;s:5:"float";d:23.230000000000000426325641456060111522674560546875;s:3:"obj";O:8:"stdClass":0:{}}';
		
		var obj = [1,2,3];
		obj.longString = 'hello world!';
		obj.undef = undefined;
		obj.bool = false;
		obj.key = 'value';
		obj.num = 23;
		obj.float = 23.23;
		obj.obj = {};		
		
		assertTrue(
			"ARRAY ALL unserialization failed!",
			ObjectUtil.compare(uns.deserialize(str), obj)
		);
		//~ Debug.dump(uns.deserialize(str));
	}

	public function testObjectAll():Void
	{
		var str:String = 'O:8:"MyClassB":5:{s:3:"arr";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}s:5:"undef";N;s:4:"bool";b:1;s:4:"hash";a:1:{s:3:"key";s:5:"value";}s:5:"float";d:23.230000000000000426325641456060111522674560546875;}';
		var obj = {arr:[1,2,3],undef: undefined, bool:true, hash:{key:'value'}, float:23.23};	

		assertTrue(
			"OBJECT ALL unserialization failed!",
			ObjectUtil.compare(uns.deserialize(str), obj)
		);
		/*
		Debug.dump(uns.deserialize(str));
		Debug.dump(obj);
		*/
	}
	
	private function assertRoundtripDeserializeEquals(obj:String, assertion)
	{
		var res = uns.deserialize(obj);
		assertEquals(
			assertion + " !== " + res,
			assertion,
			res
		);
	}

}
