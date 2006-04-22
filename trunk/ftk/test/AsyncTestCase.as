
import asunit.framework.*;
import asunit.errors.AssertionFailedError;
import asunit.errors.IllegalOperationError;

/**
 * asunit test case for async operations
 *
 * you can use this test class similar to the default asunit test case
 * class. there two major differences. the first is the {@see setUpAsync} method, 
 * that you should use to set up you asynchronous operating instances. the second
 * is that you have to deflect you event methods with {@see deflectEvent}.
 *
 * this approach is limited to simple request/response interchange, no consecutive
 * asynchronous events can be handled.
 * 
 * @package    fkt.test
 * @author     Patrick Müller <elias{edd}adaptiveinstance{dod}com>
 * @copyright  Patrick Müller
 * @license    http://www.opensource.org/licenses/lgpl-license.php  LGPL
 * @link       http://adaptiveinstance.com
 * @see        
 * @since      0.11
 * @version    SVN: $Id$
 * @version    Release: @package_version@
 */

class ftk.test.AsyncTestCase extends TestCase
{
	
	/**
	 * this method deflects an event to the current test case
	 * implementation. additionally a call to {@see runNow}
	 * is added, so the test case automatically starts if
	 * an event is received.
	 *
	 * @param	mathodName name of the event method to deflect
	 */
	public function deflectEvent(methodName:String)
	{
		var self = this;
		return function()
		{
			try {
				self.currentMethod = methodName;
				self[methodName].apply(self, arguments);
			} catch (e:AssertionFailedError){
				self.result.addFailure(self, e);
			} catch (e:Error){
				self.result.addError(self, e);
			}
			
			self.runNow();
		}
	}
	
	/**
	 * this freezes the default run method. the test case start should
	 * be triggered by events defined in setUpAsync
	 */
	public function run()
	{
		setUpAsync();
	}
	
	/**
	 * runBare is overriden to pre-test errors caused by async
	 * events, if so the complete test fails.
	 */
	public function runBare():Void
	{
		if (!result.wasSuccessful())
		{
			testMethodsExecuted = getTestMethods().length;
			return;
		}
		super.runBare();
	}
	
	/**
	 * you MUST override setUpAsync to make you async test case work.
	 * create your instances here, trigger the async operation and
	 * use {@see deflectEvent} to pass your events.
	 * 
	 */
	public function setUpAsync()
	{
		
	}

}
