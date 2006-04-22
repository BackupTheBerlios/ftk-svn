
import asunit.framework.*;
import ftk.io.HttpMessage;
import ftk.io.HttpRequest;
import ftk.io.Http;
import ftk.io.IoError;
import ftk.test.AsyncTestCase;

class test.ftk.io.HttpRequest.GetSuccessTest extends AsyncTestCase
{
	private var response:HttpMessage;
	private var error:IoError;
	private var className:String = 'test.ftk.io.HttpRequest.SuccessTest';
	
	public function setUpAsync()
	{
		var message:HttpMessage = new HttpMessage();
		message.setBody('hello world');
		
		var request:HttpRequest = new HttpRequest(
			'echo-get.php', 
			Http.METHOD_GET
		);
		request.onResponse = deflectEvent('onResponse');
		request.onTimeout = request.onFailure = deflectEvent('onFailure');
		request.send(message);
	}	

	public function test():Void
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
