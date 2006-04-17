
import ftk.io.Http;
import ftk.io.HttpRequest;
import ftk.io.HttpMessage;

class example.io.HttpRequestPlainText
{
	function HttpRequestPlainText()
	{
		var url:String = '../php/echo-http-request.php';
		var req:HttpRequest = new HttpRequest(url, Http.METHOD_POST);
		req.onResponse = function(resp)
		{
			trace('Request Successful!');
			trace('--RESPONSE-BODY-START--');
			trace(resp.getBody());
			trace('--RESPONSE-BODY-END----');
		}
		req.onFailure = function(err)
		{
			trace('Request failed. ');
			trace('ErrorMessage: ' + err.toString());
		}
		var msg:HttpMessage = new HttpMessage();
		msg.setBody('Hello World!');
		req.send(msg);
	}
		
}
