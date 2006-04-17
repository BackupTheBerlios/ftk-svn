
import ftk.io.Http;
import ftk.io.HttpRequest;
import ftk.io.HttpMessage;
import ftk.serialization.PHPSerializer;
import ftk.serialization.PHPDeserializer;

class example.io.HttpRequestPHPSerialized
{
	function HttpRequestPHPSerialized()
	{
		var url:String = '../php/echo-http-request-serialized.php';
		var request:HttpRequest = new HttpRequest(url, Http.METHOD_POST);
		request.onResponse = function(resp)
		{
			trace('Request Successful!');
			trace('--RESPONSE-BODY-START--');
			trace(resp.getBody());
			trace('--RESPONSE-BODY-END----');
		}
		request.onFailure = function(err)
		{
			trace('Request failed. ');
			trace('ErrorMessage: ' + err.toString());
		}
		var message:HttpMessage = new HttpMessage(new PHPSerializer(), new PHPDeserializer());
		message.setBody('Hello World!');
		request.send(message);
	}
		
}
