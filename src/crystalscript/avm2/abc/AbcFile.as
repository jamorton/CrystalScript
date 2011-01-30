package crystalscript.avm2.abc
{
	import crystalscript.base.*;

	public class AbcFile 
	{
		
		private var _constantPool:AbcConstantPool;
		private var _classes:HashTable;
		private var _scripts:HashTable;
		
		public function AbcFile()
		{
			_constantPool = new AbcConstantPool();
		}
		
		public function serialize():AbcByteStream
		{
			// we serialize everything topologically so that the entries that depend
			// on other entries can add their children to the AbcFile first
			// (e.g., almost all entries reference the constant pool, that is serialized last.
			var bytes:AbcByteStream = new AbcByteStream();
			bytes.uint16(AbcInfo.MINOR_VERSION);
			bytes.uint16(AbcInfo.MAJOR_VERSION);
			
			bytes.uint30(0);
			bytes.uint30(0);
			bytes.uint30(0);
			bytes.uint30(0);
			bytes.uint30(0);
			
			return bytes;
		}
		
		public function get constantPool():AbcConstantPool { return _constantPool; }
		
		
	}
	
}
