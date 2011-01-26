package crystalscript.avm2.abc 
{
	import crystalscript.avm2.name.AvmQName;

	public class AbcInstanceInfo implements IAbcEntry
	{
		
		private var _name:AvmQName;
		private var _superName:
		
		public function AbcInstanceInfo(name:AvmQName) 
		{
			_name = name;
			_superName = null;
		}
		
		public function serialize(abc:AbcFile):AbcByteStream
		{
			
		}
		
	}

}