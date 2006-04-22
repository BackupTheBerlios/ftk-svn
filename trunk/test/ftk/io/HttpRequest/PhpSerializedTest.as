
import asunit.framework.*;
import ftk.io.HttpMessage;
import ftk.io.HttpRequest;
import ftk.io.Http;
import ftk.io.IoError;
import ftk.serialization.PHPSerializer;
import ftk.serialization.PHPDeserializer;
import ftk.test.AsyncTestCase;

class test.ftk.io.HttpRequest.PhpSerializedTest extends AsyncTestCase
{
	private var response:HttpMessage;
	private var className:String = 'test.ftk.io.HttpRequest.PhpSerializedTest';
	
	public function setUpAsync()
	{
		var message:HttpMessage = new HttpMessage(new PHPSerializer(), new PHPDeserializer());
		//~ var message:HttpMessage = new HttpMessage();
		message.setBody('hello world');
		
		var request:HttpRequest = new HttpRequest(
			'echo-post-phpserialized.php', 
			Http.METHOD_POST
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
