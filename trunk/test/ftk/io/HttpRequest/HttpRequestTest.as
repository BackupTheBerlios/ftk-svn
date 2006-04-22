

import asunit.framework.*;
import ftk.io.HttpMessage;
import ftk.io.HttpRequest;
import ftk.io.Http;
import ftk.io.IoError;

class test.ftk.io.HttpRequest.HttpRequestTest extends TestCase
{
	private var request:HttpRequest;
	private var error:IoError;
	private var className:String = 'test.ftk.io.HttpRequest.HttpRequestTest';
	
	public function setUp()
	{
		request = new HttpRequest();
	}	
	
	public function testHeader()
	{
		request.setHeader('foo', 'bar');
		assertEquals('' , 'bar', request.getHeader('foo'));
	}	

}
