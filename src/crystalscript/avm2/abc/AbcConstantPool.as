package crystalscript.avm2.abc 
{
	import crystalscript.avm2.name.AvmMultiname;
	import crystalscript.avm2.name.AvmNamespace;
	import crystalscript.avm2.name.AvmNamespaceSet;
	import crystalscript.avm2.name.IMultiname;
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
		
		private var _intIdx:Vector.<int>;
		private var _uintIdx:Vector.<uint>;
		private var _doubleIdx:Vector.<Number>;
		private var _stringIdx:Vector.<String>;
		private var _namespaceIdx:Vector.<AvmNamespace>;
		private var _nssetIdx:Vector.<AvmNamespaceSet>;
		private var _multinameIdx:Vector.<IMultiname>;
		
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
			
			_intIdx       = new Vector.<int>();
			_uintIdx      = new Vector.<uint>();
			_doubleIdx    = new Vector.<Number>();
			_stringIdx    = new Vector.<String>();
			_namespaceIdx = new Vector.<AvmNamespace>();
			_nssetIdx     = new Vector.<AvmNamespaceSet>();
			_multinameIdx = new Vector.<IMultiname>(); 
		}                  
		    
		public function int32(val:int):uint 
		{
			if (val == 0) return 0;
			var index:uint = _intMap.read(val);
			if (index == 0)
			{
				index = _intLength++;
				_intMap.write(val, index);
				_intIdx.push(val);
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
				_uintIdx.push(val);
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
				_doubleIdx.push(val);
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
				_stringIdx.push(val);
			}
			return index;
		}
		
		/**
		 * @author Tamarin Project, modified slightly
		 */
		public  function utf8length(s:String):uint
		{
			var limit:uint = s.length;
			
			for (var i:uint = 0; i < limit && s.charCodeAt(i) < 128 ; i++ )
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
				_nssetIdx.push(val);
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
				_namespaceIdx.push(val);
			}
			return index;
		}
		
		public function multiname(val:IMultiname):uint
		{
			if (val.name == "*" || !val) return 0;
			var index:uint = _multinameMap.read(val);
			if (index == 0) 
			{
				index = _multinameLength++;
				_multinameMap.write(val, index);
				_multinameIdx.push(val);
			}
			return index;
		}
		
		public function serialize(bytes:AbcByteStream):void
		{
			
			var o:Object;
			
			// Namespaces, multinames, etc have to be written first
			// to make sure the indexes they reference exist (strings, etc)
			
			/***** MULTINAMES ****/
			var multiname_tmp:AbcByteStream = new AbcByteStream();
			for each(o in _multinameMap.toArray()) 
			{
				multiname_tmp.uint8(o.key.kind);
				switch (o.key.kind) 
				{
					case AbcInfo.CONSTANT_QName:
						multiname_tmp.uint30(namespace_(o.key.ns));
					case AbcInfo.CONSTANT_Multiname:
					case AbcInfo.CONSTANT_RTQName:
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
			for each(o in _nssetIdx) 
			{
				nsset_tmp.uint30(o.length);
				for each(var i:AvmNamespace in o.namespaces)
					nsset_tmp.uint30(namespace_(i));
			}
			
			/***** NAMESPACES ****/
			var ns_tmp:AbcByteStream = new AbcByteStream();
			for each(o in _namespaceIdx)
			{
				ns_tmp.uint8(o.kind);
				ns_tmp.uint30(utf8(o.name));
			}
			
			
			// subtract one from length because the default values aren't counted
			
			bytes.uint30(_intLength - 1);
			for each(o in _intIdx)
				bytes.int32(int(o));
			
			bytes.uint30(_uintLength - 1);
			for each(o in _uintIdx)
				bytes.uint32(uint(o));
			
			bytes.uint30(_doubleLength - 1);
			for each(o in _doubleIdx) 
				bytes.float64(Number(o));
			
			bytes.uint30(_stringLength - 1);
			for each(o in _stringIdx) 
			{
				bytes.uint30(utf8length(String(o)));
				bytes.utf8(String(o));
			}
			
			bytes.uint30(_namespaceLength - 1);
			bytes.addBytes(ns_tmp);
			
			bytes.uint30(_nssetLength - 1);
			bytes.addBytes(nsset_tmp);
			
			bytes.uint30(_multinameLength - 1);
			bytes.addBytes(multiname_tmp);
			
		}
	}
}
