package crystalscript.avm2.abc 
{
	import crystalscript.avm2.name.AvmMultiname;
	import crystalscript.avm2.name.AvmNamespace;
	import crystalscript.avm2.name.AvmNamespaceSet;
		
	/**
	 * @see AbcConstantPool in ESC sources
	 * @author Jon Morton
	 */
	public class AbcConstantPool implements IAbcEntry
	{
		
		private var _intBytes:AbcByteStream;
		private var _uintBytes:AbcByteStream;
		private var _doubleBytes:AbcByteStream;
		private var _stringBytes:AbcByteStream;
		private var _namespaceBytes:AbcByteStream;
		private var _nssetBytes:AbcByteStream;
		private var _multinameBytes:AbcByteStream;
		
		private var _intMap:Array;
		private var _uintMap:Array;
		private var _doubleMap:Array;
		private var _stringMap:Array;
		private var _namespaceMap:Array;
		private var _nssetMap:Array;
		private var _multinameMap:Array;
		
		public function AbcConstantPool()
		{
			_intMap       = new Array(); _intMap.length       = 1;
			_uintMap      = new Array(); _uintMap.length      = 1;
			_doubleMap    = new Array(); _doubleMap.length    = 1;
			_stringMap    = new Object(); _stringMap.length    = 1;
			_namespaceMap = new Object(); _namespaceMap.length = 1;
			_nssetMap     = new Object(); _nssetMap.length     = 1;
			_multinameMap = new Object(); _multinameMap.length = 1;
			
			_intBytes       = new AbcByteStream();
			_uintBytes      = new AbcByteStream();
			_doubleBytes    = new AbcByteStream();
			_stringBytes    = new AbcByteStream();
			_namespaceBytes = new AbcByteStream();
			_nssetBytes     = new AbcByteStream();
			_multinameBytes = new AbcByteStream();
		}                            
		
		public function int32(val:int):uint 
		{
			if (val == 0) return 0;
			var index:uint = _intMap[val];
			if (index == undefined)
			{
				index = _intMap.length;
				_intMap[val] = index;
				_intBytes.int32(val);
			}
			return index;
		}
		
		public function uint32(val:int):uint 
		{
			if (val == 0) return 0;
			var index:uint = _uintMap[val];
			if (index == undefined)
			{
				index = _uintMap.length;
				_uintMap[val] = index;
				_uintBytes.uint32(val);
			}
			return index;
		}
		
		public function float64(val:Number):uint 
		{
			if (isNaN(val)) return 0;
			var index:uint = _doubleMap[val];
			if (index == undefined)
			{
				index = _doubleMap.length;
				_uintMap[val] = index;
				_doubleBytes.float64(val);
			}
			return index;
		}
		
		public function utf8(val:String):uint 
		{
			if (val == "" || !val) return 0;
			var index:uint = _stringMap[val];
			if (index == undefined)
			{
				index = _stringMap.length;
				_stringMap[val] = index;
				_stringBytes.uint30(utf8length(val));
				_stringBytes.utf8(val);
			}
			return index;
		}
		
		/**
		 * @author Tamarin Project
		 */
		function utf8length(s:String):uint
		{
			var i:uint = 0;
			var limit:uint = 0;
			
			for (; i < limit && s.charCodeAt(i) < 128 ; i++ )
				;
			if (i == limit)
				return limit;
			
			var b:AbcByteStream = new AbcByteStream();
			b.utf8(s);
			return b.length;
		}
		
		public function NamespaceSet_(val:AvmNamespaceSet):uint 
		{
			if (!val || val.length < 1) return 0;
			var hash:String = val.hash();
			var index:uint = _nssetMap[hash];
			if (index == undefined) 
			{
				index = _nssetMap.length;
				_nssetMap[hash] = index;
				_nssetBytes.uint30(val.length);
				for each(var ns:Avm2Namespace in val.namespaces)
					_nssetBytes.uint30(Namespace_(ns));
			}
			return index;
		}
		
		public function Namespace_(val:AvmNamespace):uint
		{
			if (val.name == "*" | !val) return 0;
			var hash:String = val.hash();
			var index:uint = _namespaceMap[hash];
			if (index == undefined) 
			{
				index = _namespaceMap.length;
				_namespaceMap[hash] = index;
				_namespaceBytes.uint8(val.kind);
				_namespaceBytes.uint30(utf8(val.name));
			}
			return index;
		}
		
		
		// no support for E4X attributes (RTQNameA, MultinameA, etc) yet..
		// do we need it?
		
		public function QName_(val:AvmMultiname):uint 
		{
			var hash:String = val.hash();
			var index:uint = _multinameMap[hash];
			if (index == undefined) 
			{
				index = _multinameMap.length
				_multinameMap[val.hash()] = index;
				_multinameBytes.uint8(val.kind);
				_multinameBytes.uint30(val.ns);
				_multinameBytes.uint30(val.name);
			}
			return index;
		}
		
		public function RTQName_(val:AvmMultiname):uint 
		{
			var hash:String = val.hash();
			var index:uint = _multinameMap[hash];
			if (index == undefined) 
			{
				index = _multinameMap.length
				_multinameMap[val.hash()] = index;
				_multinameBytes.uint8(val.kind);
				_multinameBytes.uint30(val.name);
			}
			return index;
		}
		
		public function RTQNameL_(val:AvmMultiname):uint
		{
			var hash:String = val.hash();
			var index:uint = _multinameMap[hash];
			if (index == undefined) 
			{
				index = _multinameMap.length
				_multinameMap[val.hash()] = index;
				_multinameBytes.uint8(val.kind);
			}
			return index;
		}
		
		public function Multiname_(val:AvmMultiname):uint
		{
			var hash:String = val.hash();
			var index:uint = _multinameMap[hash];
			if (index == undefined) 
			{
				index = _multinameMap.length
				_multinameMap[val.hash()] = index;
				_multinameBytes.uint8(val.kind);
				_multinameBytes.uint30(val.name);
				_multinameBytes.uint30(val.ns);
			}
			return index;
		}
		
		public function MultinameL_(val:AvmMultiname):uint
		{
			var hash:String = val.hash();
			var index:uint = _multinameMap[hash];
			if (index == undefined) 
			{
				index = _multinameMap.length
				_multinameMap[val.hash()] = index;
				_multinameBytes.uint8(val.kind);
				_multinameBytes.uint30(val.ns);
			}
			return index;
		}
		
		public function serialize():AbcByteStream
		{
			var write:AbcByteStream = new AbcByteStream();
			
			write.uint30(_intMap.length);
			write.addBytes(_intBytes);
			
			write.uint30(_uintMap.length);
			write.addBytes(_uintBytes);
			
			write.uint30(_doubleMap.length);
			write.addBytes(_doubleBytes);
			
			write.uint30(_stringMap.length);
			write.addBytes(_stringBytes);
			
			write.uint30(_namespaceMap.length);
			write.addBytes(_namespaceBytes);
			
			write.uint30(_nssetMap.length);
			write.addBytes(_nssetBytes);
			
			write.uint30(_multinameMap.length);
			write.addBytes(_multinameBytes);
			
			return write;
		}
	}
}
