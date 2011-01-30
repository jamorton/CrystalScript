package crystalscript.avm2.abc
{
	import crystalscript.base.*;

	public class AbcFile 
	{
		private var _constantPool:AbcConstantPool;
		private var _class:HashTable;
		private var _script:HashTable;
		private var _methodInfo:HashTable;
		private var _methodBody:HashTable;
		
		private static const NO_VALUE:uint = uint.MAX_VALUE;
		
		public function AbcFile()
		{
			_constantPool = new AbcConstantPool();
			_class        = new HashTable(NO_VALUE);
			_script       = new HashTable(NO_VALUE);
			_methodInfo   = new HashTable(NO_VALUE);
			_methodBody   = new HashTable(NO_VALUE);
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
		
		public function addClass(val:AbcClass):uint      { return doAdd(val, _class);      }
		public function addScript(val:AbcClass):uint     { return doAdd(val, _script);     }
		public function addMethodInfo(val:AbcClass):uint { return doAdd(val, _methodInfo); }
		public function addMethodBody(val:AbcClass):uint { return doAdd(val, _methodBody); }
		
		private function serializeEntry(table:HashTable):AbcByteStream
		{
			var bytes:AbcByteStream = new AbcByteStream();
			var entries:Array = table.toArray();
			bytes.uint30(table.size);
			entries.sortOn("value", Array.NUMERIC);
			for each (var entry:IAbcEntry in entries)
			{
				bytes.addBytes(entry.serialize(this));
			}
			return bytes;
		}
		
		private static function doAdd(val:IAbcEntry, table:HashTable):uint
		{
			var index:int = table.read(val);
			if (index == NO_VALUE)
			{
				index = table.size;
				table.write(val, index);
			}
			return index;
		}
		
		public function get constantPool():AbcConstantPool { return _constantPool; }
	}
	
}
