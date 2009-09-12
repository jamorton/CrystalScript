package crystalscript.avm2.abc 
{
	import crystalscript.avm2.name.AvmMultiname;
	import crystalscript.avm2.name.AvmNamespace;
	import crystalscript.avm2.name.AvmNamespaceSet;
	import crystalscript.etc.HashTable;
	import crystalscript.etc.Util;
		
	/**
	 * @see AbcConstantPool in ESC sources
	 * @author Jon Morton
	 */
	public class AbcConstantPool implements IAbcEntry
	{
		private var _intMap:HashTable;
		private var _uintMap:HashTable;
		private var _doubleMap:HashTable;
		private var _stringMap:HashTable;
		private var _namespaceMap:HashTable;
		private var _nssetMap:HashTable;
		private var _multinameMap:HashTable;
		
		private var _intLength:uint       = 1;
		private var _uintLength:uint      = 1;
		private var _doubleLength:uint    = 1;
		private var _stringLength:uint    = 1;
		private var _namespaceLength:uint = 1;
		private var _nssetLength:uint     = 1;
		private var _multinameLength:uint = 1;
		
		public function AbcConstantPool()
		{
			function eqn(a:*, b:*):Boolean 
			{
				return a == b;
			}
			
			_intMap       = new HashTable(Util.hashNumber, eqn, 0);
			_uintMap      = new HashTable(Util.hashNumber, eqn, 0);
			_doubleMap    = new HashTable(Util.hashNumber, eqn, 0);
			_stringMap    = new HashTable(Util.hashString, eqn, 0);
			_namespaceMap = new HashTable(null, null, 0);
			_nssetMap     = new HashTable(null, null, 0);
			_multinameMap = new HashTable(null, null, 0);
		}                            
		
		public function int32(val:int):uint 
		{
			if (val == 0) return 0;
			var index:uint = _intMap.read(val);
			if (index == 0)
			{
				index = _intLength++;
				_intMap.write(val, index);
			}
			return index;
		}
		
		public function uint32(val:int):uint 
		{
			if (val == 0) return 0;
			var index:uint = _uintMap.read(val);
			if (index == 0)
			{
				index = _uintLength++;
				_uintMap.write(val, index);
			}
			return index;
		}
		
		public function float64(val:Number):uint 
		{
			if (isNaN(val)) return 0;
			var index:uint = _doubleMap.read(val);
			if (index == 0)
			{
				index = _doubleLength++;
				_doubleMap.write(val, index);
			}
			return index;
		}
		
		public function utf8(val:String):uint 
		{
			if (val == "" || !val) return 0;
			var index:uint = _stringMap.read(val);
			if (index == 0)
			{
				index = _stringLength++;
				_stringMap.write(val, index);
			}
			return index;
		}
		
		/**
		 * @author Tamarin Project
		 */
		public  function utf8length(s:String):uint
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
		
		public function namespaceset(val:AvmNamespaceSet):uint 
		{
			if (!val || val.length < 1) return 0;
			var index:uint = _nssetMap.read(val);
			if (index == 0) 
			{
				index = _nssetLength++;
				_nssetMap.write(val, index);
			}
			return index;
		}
		
		public function namespace_(val:AvmNamespace):uint
		{
			if (val.name == "*" || !val) return 0;
			var index:uint = _namespaceMap.read(val);
			if (index == 0) 
			{
				index = _namespaceLength++;
				_namespaceMap.write(val, index);
			}
			return index;
		}
		
		public function multiname(val:AvmMultiname):uint
		{
			if (val.name == "*" || !val) return 0;
			var index:uint = _multinameMap.read(val);
			if (index == 0) 
			{
				index = _multinameLength++;
				_multinameMap.write(val, index);
			}
			return index;
		}
		// no support for E4X attributes (RTQNameA, MultinameA, etc) yet..
		// do we need it?
		/*
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
		*/
		
		public function serialize(bytes:AbcByteStream):void
		{
			
			var o:Object;
			
			// this is just a big fucking hack. grrarrggh >:(
			
			// Namespaces, multinames, etc have to be written first
			// to make sure the indexes they reference exist (strings, etc)
			
			
			/***** MULTINAMES ****/
			var multiname_tmp:AbcByteStream = new AbcByteStream();
			for each(o in _multinameMap.toArray()) 
			{
				multiname_tmp.uint8(o.key.KIND);
				switch (o.key.KIND) 
				{
					case AbcInfo.CONSTANT_Qname:
						multiname_tmp.uint30(namespace_(o.key.ns));
					case AbcInfo.CONSTANT_Multiname:
					case AbcInfo.CONSTANT_RTQname:
						multiname_tmp.uint30(utf8(o.key.name));
						break;
					case AbcInfo.CONSTANT_Multiname:
					case AbcInfo.CONSTANT_MultinameL:
						multiname_tmp.uint30(namespaceset(o.key.nsset));
						break;
				}
			}
			
			/***** NAMESPACE SETS ****/
			var nsset_tmp:AbcByteStream = new AbcByteStream();
			for each(o in _nssetMap.toArray()) 
			{
				nsset_tmp.uint30(o.key.length);
				for each(var i:AvmNamespace in o.key.namespaces)
					nsset_tmp.uint30(namespace_(i));
			}
			
			/***** NAMESPACES ****/
			var ns_tmp:AbcByteStream = new AbcByteStream();
			for each(o in _namespaceMap.toArray()) 
			{
				ns_tmp.uint8(o.key.kind);
				ns_tmp.uint30(utf8(o.key.name));
			}
			
			
			
			bytes.uint30(_intLength);
			for each(o in _intMap.toArray()) 
				bytes.int32(o.key);
			
			bytes.uint30(_uintLength);
			for each(o in _uintMap.toArray()) 
				bytes.uint32(o.key);
			
			bytes.uint30(_doubleLength);
			for each(o in _doubleMap.toArray()) 
				bytes.float64(o.key);
			
			bytes.uint30(_stringLength);
			for each(o in _doubleMap.toArray()) 
			{
				bytes.uint30(utf8length(o.key));
				bytes.float64(o.key);
			}
			
			bytes.uint30(_namespaceLength);
			bytes.addBytes(ns_tmp);
			
			bytes.uint30(_nssetLength);
			bytes.addBytes(nsset_tmp);
			
			bytes.uint30(_multinameLength);
			bytes.addBytes(multiname_tmp);
			
		}
	}
}
