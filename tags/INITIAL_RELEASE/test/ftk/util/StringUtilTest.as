
import asunit.framework.*;
import ftk.util.StringUtil;

class test.ftk.util.StringUtilTest extends TestCase
{

	public function StringUtilTest(){};
	
	public function setUp():Void
	{
	}
	
	public function tearDown():Void
	{
	}

	/*
	public function test_format():Void
	{
			
		assertEquals(
			"single argument: {0}",
			StringUtil.format('{0}', 'arg1'),
			"arg1"
		);
		assertEquals(
			"single argument, rudimant before: ,{0}",
			StringUtil.format(',{0}', 'arg1'),
			",arg1"
		);
		assertEquals(
			"single argument, rudimant after: {0},",
			StringUtil.format('{0},', 'arg1'),
			"arg1,"
		);
		assertEquals(
			"single argument, rudimant both: ,{0},",
			StringUtil.format(',{0},', 'arg1'),
			",arg1,"
		);
		assertEquals(
			"arguments parsing order: {0}{1}{2}{1}{0}",
			StringUtil.format('{0}{1}{2}{1}{0}', 0, 1, 2),
			"01210"
		);
		assertEquals(
			"arguments parsing order with rudiments: {0}{1}{2}{1}{0}",
			StringUtil.format(',{0},{1},{2},{1},{0},', 0, 1, 2),
			",0,1,2,1,0,"
		);
		assertEquals(
			"plain ecaped curly brace: {{{0}",
			StringUtil.format('{{{0}', 'arg1'),
			"{arg1"
		);
		assertEquals(
			"plain ecaped curly brace, rudiment: ,,,{{,,,{0},,,",
			StringUtil.format(',,,{{,,,{0},,,', 'arg1'),
			",,,{,,,arg1,,,"
		);
		assertEquals(
			"adjusted positive width right: {0,5}",
			StringUtil.format('{0,5}', 'arg1'),
			" arg1"
		);
		assertEquals(
			"adjusted positive width left: {0,-5}",
			StringUtil.format('{0,-5}', 'arg1'),
			"arg1 "
		);
		assertEquals(
			"adjusted positive width by char right: {0,5:_}",
			StringUtil.format('{0,5:_}', 'arg1'),
			"_arg1"
		);
		assertEquals(
			"adjusted positive width by char left: {0,-5:_}",
			StringUtil.format('{0,-5:_}', 'arg1'),
			"arg1_"
		);
		assertEquals(
			"adjusted negative width right: {0,3}",
			StringUtil.format('{0,3}', 'arg1'),
			"arg"
		);
		assertEquals(
			"adjusted negative width left: {0,-3}",
			StringUtil.format('{0,-3}', 'arg1'),
			"rg1"
		);
	}
	*/
	public function test_repeat():Void
	{
		assertEquals(
			"string not repeated 5 times",
			StringUtil.repeat('a', 5),
			"aaaaa"
		);
	}
	
	public function test_padLeft():Void
	{
		assertEquals(
			"",
			StringUtil.padLeft('test', '+', 5),
			"+++++test"
		);
	}
	
	public function test_padRigth():Void
	{
		assertEquals(
			"",
			StringUtil.padRight('test', '+', 5),
			"test+++++"
		);
	}
	
	public function test_trimRight():Void
	{
		assertEquals(
			"",
			StringUtil.trimRight('test\n\r\t '),
			"test"
		);
	}
	
	public function test_trimRightCustom():Void
	{
		assertEquals(
			"",
			StringUtil.trimRight('testabc', 'cab'),
			"test"
		);
	}
	
	public function test_trimLeft():Void
	{
		assertEquals(
			"",
			StringUtil.trimLeft('\n\r\t test'),
			"test"
		);
	}
	
	public function test_trimLeftCustom():Void
	{
		assertEquals(
			"",
			StringUtil.trimLeft('abctest', 'cab'),
			"test"
		);
	}
	
	public function test_trim():Void
	{
		assertEquals(
			"",
			StringUtil.trim('\n\r\t test\n\r\t '),
			"test"
		);
	}

	public function test_trimCustom():Void
	{
		assertEquals(
			StringUtil.trim('abctestabc', 'cab'),
			StringUtil.trim('abctestabc', 'cab'),
			"test"
		);
	}
	
	public function test_startsWith():Void
	{
		assertTrue(
			"args('test', 'te')",
			StringUtil.startsWith('test', 'te')
		);
		assertFalse(
			"args('test', 'tet')",
			StringUtil.startsWith('test', 'tet')
		);
		assertFalse(
			"args('test', 'testtest')",
			StringUtil.startsWith('test', 'testtest')
		);
	}
	
	public function test_endsWith():Void
	{
		assertTrue(
			"args('test', 'st')",
			StringUtil.endsWith('test', 'st')
		);
		assertFalse(
			"args('test', 'tst')",
			StringUtil.endsWith('test', 'tst')
		);
		assertFalse(
			"args('test', 'testtest')",
			StringUtil.endsWith('test', 'testtest')
		);
	}
	
}
