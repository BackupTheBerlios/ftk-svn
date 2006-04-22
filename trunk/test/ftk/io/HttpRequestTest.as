

import asunit.framework.*;
import ftk.io.HttpMessage;
import ftk.io.HttpRequest;
import ftk.io.Http;
import ftk.io.IoError;
import ftk.test.AsyncTestCase;

class test.ftk.io.HttpRequestTest extends AsyncTestCase
{
	private var response:HttpMessage;
	private var error:IoError;
	private var className:String = 'test.ftk.io.HttpRequestTest';
	
	public function setUpAsync()
	{
		var message:HttpMessage = new HttpMessage();
		message.setBody('hello world');
		
		var request:HttpRequest = new HttpRequest(
			'HttpRequestEcho.php', 
			Http.METHOD_POST
		);
		request.onResponse = deflectEvent('onResponse');
		request.onTimeout = request.onFailure = deflectEvent('onFailure');
		request.send(message);
	}	

	public function testFoo():Void
	{
		assertEquals(
			'"hello world" != "'+response.getBody()+'"',
			"hello world",
			response.getBody()
		);
	
	}

	public function onResponse(msg:HttpMessage):Void
	{
		response = msg;
	}

	public function onFailure(e:IoError):Void
	{
		fail(e.getMessage());
	}
	
}
