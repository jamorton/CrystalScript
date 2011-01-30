package crystalscript.avm2.abc 
{

	public class AbcScript implements IAbcEntry
	{
		
		private var _init:AbcMethodInfo;
		
		public function AbcScript(init:AbcMethodInfo) 
		{
			_init = init;
		}
		
		public function serialize(abc:AbcFile):AbcByteStream
		{
			var bytes:AbcByteStream = new AbcByteStream();
			abc.addMethodInfo(_init);
			bytes.uint30(0); // traits
			return bytes;
		}
		
		public function get init():AbcMethodInfo { return _init; }
		
	}

}