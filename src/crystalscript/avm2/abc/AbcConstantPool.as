﻿package crystalscript.avm2.abc 
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
				index = _intIdx.length + 1;
				_intMap.write(val, index);
				_intIdx.push(val);
			}
			return index;
		}
		
		public function uint32(val:uint):uint 
		{
			if (val == 0) return 0;
			var index:uint = _uintMap.read(val);
			if (index == 0)
			{
				index = _uintIdx.length + 1;
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
				index = _doubleIdx.length + 1;
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
				index = _stringIdx.length + 1;
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
			
			for (var i:uint = 0; i < limit && s.charCodeAt(i) < 128 ; i++);
			
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
				index = _nssetIdx.length + 1;
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
				index = _namespaceIdx.length + 1;
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
				index = _multinameIdx.length + 1;
				_multinameMap.write(val, index);
				_multinameIdx.push(val);
			}
			return index;
		}
		
		public function serialize(bytes:AbcByteStream):void
		{
			
			// Namespaces, multinames, etc have to be written first
			// to make sure the indexes they reference exist (strings, etc)
			
			/***** MULTINAMES ****/
			var multiname_tmp:AbcByteStream = new AbcByteStream();
			for each(var mn:Object in _multinameIdx) 
			{
				multiname_tmp.uint8(mn.kind);
				switch (mn.kind)
				{
					case AbcInfo.CONSTANT_QName:
						multiname_tmp.uint30(namespace_(mn.ns));
					case AbcInfo.CONSTANT_RTQName:
						multiname_tmp.uint30(utf8(mn.name));
						break;
					case AbcInfo.CONSTANT_MultinameL:
						multiname_tmp.uint30(namespaceset(mn.nsset));
						break;
					case AbcInfo.CONSTANT_Multiname:
						multiname_tmp.uint30(utf8(mn.name));
						multiname_tmp.uint30(namespaceset(mn.nsset));
						break;
				}
			}
			
			/***** NAMESPACE SETS ****/
			var nsset_tmp:AbcByteStream = new AbcByteStream();
			for each(var nss:AvmNamespaceSet in _nssetIdx) 
			{
				nsset_tmp.uint30(nss.length);
				for each(var n:AvmNamespace in nss.namespaces)
					nsset_tmp.uint30(namespace_(n));
			}
			
			/***** NAMESPACES ****/
			var ns_tmp:AbcByteStream = new AbcByteStream();
			for each(var ns:AvmNamespace in _namespaceIdx)
			{
				ns_tmp.uint8(ns.kind);
				ns_tmp.uint30(utf8(ns.name));
			}
			
			bytes.uint30(_intIdx.length + 1);
			for each(var i:int in _intIdx)
				bytes.int32(i);
				
			bytes.uint30(_uintIdx.length + 1);
			for each(var u:uint in _uintIdx)
				bytes.uint32(u);
			
			bytes.uint30(_doubleIdx.length + 1);
			for each(var d:Number in _doubleIdx)
				bytes.float64(d);
			
			bytes.uint30(_stringIdx.length + 1);
			for each(var s:String in _stringIdx)
			{
				bytes.uint30(utf8length(s));
				bytes.utf8(s);
			}
			
			bytes.uint30(_namespaceIdx.length + 1);
			bytes.addBytes(ns_tmp);
			
			bytes.uint30(_nssetIdx.length + 1);
			bytes.addBytes(nsset_tmp);
			
			bytes.uint30(_multinameIdx.length + 1);
			bytes.addBytes(multiname_tmp);
			
		}
	}
}
