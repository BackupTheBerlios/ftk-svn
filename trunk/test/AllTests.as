
import ftk.util.Debug;
import asunit.framework.*;
import asunit.textui.TestRunner;

/* - TESTS - */
import test.ftk.serialization.*;
import test.ftk.util.StringUtilTest;
import test.ftk.util.ObjectUtilTest;
/* - TESTS - */

class AllTests extends TestSuite
{
	static var allTests:AllTests = null;
	static public function main():Void
	{
		Debug.init();
		Debug.setVerboseTrace(true);
		trace('foo');
		
		var tr:TestRunner = new TestRunner();
		tr.start(AllTests);
	}

	public function AllTests()
	{
		super();
		addTest(new PHPSerializerTest());
		addTest(new PHPDeserializerTest());
		addTest(new StringUtilTest());
		addTest(new ObjectUtilTest());
		//~ throw new ftk.core.error.RecursionLimitError('pooh', 10);
		//~ run();
	}
}
