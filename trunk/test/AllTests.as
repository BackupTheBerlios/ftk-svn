
import ftk.util.Debug;
import asunit.framework.*;
import asunit.textui.TestRunner;

class AllTests extends TestSuite
{
	static var allTests:AllTests = null;
	static public function main():Void
	{
		//~ Debug.init();
		//~ Debug.setVerboseTrace(true);
	
		var tr:TestRunner = new TestRunner();
		tr.start(AllTests);
	}

	public function AllTests()
	{
		super();
		addTest(new test.ftk.serialization.PHPSerializerTest());
		addTest(new test.ftk.serialization.PHPDeserializerTest());
		addTest(new test.ftk.util.StringUtilTest());
		addTest(new test.ftk.util.ObjectUtilTest());
		addTest(new test.ftk.io.HttpRequest.HttpRequestTest());
		addTest(new test.ftk.io.HttpRequest.UnknownUrlTest());
		addTest(new test.ftk.io.HttpRequest.SuccessTest());
		addTest(new test.ftk.io.HttpRequest.GetSuccessTest());
		addTest(new test.ftk.io.HttpRequest.PhpSerializedTest());
	}
}
