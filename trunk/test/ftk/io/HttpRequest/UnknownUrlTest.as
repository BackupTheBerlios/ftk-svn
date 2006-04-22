

import asunit.framework.*;
import ftk.io.HttpMessage;
import ftk.io.HttpRequest;
import ftk.io.Http;
import ftk.io.IoError;
import ftk.test.AsyncTestCase;

class test.ftk.io.HttpRequest.UnknownUrlTest extends AsyncTestCase
{
	private var response:HttpMessage;
	private var error:IoError;
	private var className:String = 'test.ftk.io.HttpRequest.UnknownUrlTest';
	
	public function setUpAsync()
	{
		var message:HttpMessage = new HttpMessage();
		message.setBody('hello world');
		
		var request:HttpRequest = new HttpRequest(
			'this_file_does_not_exist.php', 
			Http.METHOD_POST
		);
		request.onResponse = deflectEvent('onResponse');
		request.onTimeout = deflectEvent('onTimeout')
		request.onFailure = deflectEvent('onFailure');
		request.send(message);
	}	

	public function test():Void
	{
		assertTrue(
			'',
			error instanceof IoError
		);
	
	}

	public function onResponse(msg:HttpMessage):Void
	{		
		response = msg;
	}

	public function onFailure(e:IoError):Void
	{
		error = e;
	}
	
	public function onTimeout(e:IoError):Void
	{
		fail(e.getMessage());
	}
	
}
