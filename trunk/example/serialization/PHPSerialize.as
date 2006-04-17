
import ftk.serialization.PHPSerializer;
import ftk.serialization.PHPDeserializer;
import ftk.util.ObjectUtil;

class example.serialization.PHPSerialize
{
	function PHPSerialize()
	{
		var myData:Object = {hello: "world"};
		trace('myData:');
		ObjectUtil.dump(myData);
				
		var serializer:PHPSerializer = new PHPSerializer();
		var myDataSerialized:String = serializer.serialize(myData);
		trace('\nmyDataSerialized:');
		ObjectUtil.dump(myDataSerialized);
				
		var deserializer:PHPDeserializer = new PHPDeserializer();
		var myDataDeserialized:Object = deserializer.deserialize(myDataSerialized);
		trace('\nmyDataDeserialized:');
		ObjectUtil.dump(myDataDeserialized);
		
	}
		
}
