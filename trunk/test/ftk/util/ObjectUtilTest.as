
import asunit.framework.*;
import ftk.io.serialization.PHPDeserializer;
import ftk.util.ObjectUtil;

/**
 * testcase for ObjectUtil
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
class test.ftk.util.ObjectUtilTest extends TestCase
{

	private var uns;
	
	public function ObjectUtilTest()
	{
	}
	
	public function setUp():Void
	{
	}
	
	public function tearDown():Void
	{
	}
	
	public function test_hasValues():Void
	{
		var o = {};
		assertFalse(
			"",
			ObjectUtil.hasValues(o)
		);
		o = {val:0};
		assertTrue(
			"",
			ObjectUtil.hasValues(o)
		);
	}
	
	public function test_getLength():Void
	{
		var o = {};
		assertEquals(
			"",
			0,
			ObjectUtil.getLength(o)
		);
		o = {val:0, foo:1};
		assertEquals(
			"",
			2,
			ObjectUtil.getLength(o)
		);
	}
	
	private function assertDumpEquals(assertion:String, obj):Void
	{
		var res:String = ObjectUtil.dump(obj, true);
		assertEquals(
			"<"+res + "> !== <" + assertion + ">",
			//~ + "\n\t<"+res.length + "> !== <" + assertion.length + ">",
			assertion,
			res
		);
	}
	
	public function test_dumpEmptyObject():Void
	{
		assertDumpEquals(
			"(object) \"[object Object]\"\n",
			{}
		);
	}
	
	public function test_dumpEmptyArray():Void
	{
		assertDumpEquals(
			"(array) \"\"\n",
			[]
		);
	}
	
	public function test_dumpBoolean():Void
	{
		assertDumpEquals(
			"(boolean) \"true\"\n",
			true
		);
		assertDumpEquals(
			"(boolean) \"false\"\n",
			false
		);
	}
	
	public function test_dumpNumber():Void
	{
		assertDumpEquals(
			"(number) \"0\"\n",
			0
		);
		assertDumpEquals(
			"(number) \"977634.36\"\n",
			977634.36
		);
	}
	
	public function test_dumpString():Void
	{
		assertDumpEquals(
			"(string) \"sfglksg slfkjg gs flkj\"\n",
			"sfglksg slfkjg gs flkj"
		);
		assertDumpEquals(
			"(string) \"foBar=\t\"foo\\bar\"\"\n",
			"foBar=\t\"foo\\bar\""
		);
	}
	
	public function test_dumpXML():Void
	{
		assertDumpEquals(
			"(XML) \"<test>foo</test>\"\n",
			new XML("<test>foo</test>")
		);
		assertDumpEquals(
			"(XMLNode) \"<test>foo</test>\"\n",
			(new XML("<test>foo</test>")).firstChild
		);
	}
	
	public function test_dumpNestedXML():Void
	{
		assertDumpEquals(
			"(array) {\n\t[0] => (XML) {\n\t\t<test>foo</test>\n\t}\n",
			[new XML("<test>foo</test>")]
		);
		assertDumpEquals(
			"(array) {\n\t[0] => (XMLNode) {\n\t\t<test>foo</test>\n\t}\n",
			[(new XML("<test>foo</test>")).firstChild]
		);
	}
	
	public function test_dumpFunction():Void
	{
		assertDumpEquals(
			'(function) "[type Function]"\n',
			function(){}
		);
	}

}
