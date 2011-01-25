package crystalscript.avm2.abc
{
	import crystalscript.etc.Util;
	
	/**
	 * note: Doesn't really represent a file, per-se, but it's close enough.
	 */
	public class AbcFile 
	{
		
		private var _constantPool:AbcConstantPool;
		
		public function AbcFile() 
		{
		}
		
		public function serialize():AbcByteStream
		{
			Util.assert(_constantPool != null, "Constant pool not set");
			
			var bytes:AbcByteStream = new AbcByteStream();
			bytes.uint16(AbcInfo.MINOR_VERSION);
			bytes.uint16(AbcInfo.MAJOR_VERSION);
			
			_constantPool.serialize(bytes);
			
			bytes.uint30(0);
			bytes.uint30(0);
			bytes.uint30(0);
			bytes.uint30(0);
			bytes.uint30(0);
			
			return bytes;
		}
		
		public function get constantPool():AbcConstantPool { return _constantPool; }
		
		public function set constantPool(value:AbcConstantPool):void 
		{
			_constantPool = value;
		}
		
		
		
	}
	
}
