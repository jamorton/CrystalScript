package crystalscript.avm2.abc 
{
	import crystalscript.avm2.name.*;
	import crystalscript.base.*;
		
	/**
	 * @see AbcConstantPool in ESC sources
	 */
	public class AbcConstantPool implements IAbcEntry
	{
		private var _ints:HashTable;
		private var _uintsHashTable;
		private var _doubles:HashTable;
		private var _strings:HashTable;
		private var _namespaces:HashTable;
		private var _nssets:HashTable;
		private var _multinames:HashTable;
		
		private const MULTINAME_DEFAULT:IMultiname = Names.any();
		
		public function AbcConstantPool()
		{
			_ints       = new HashTable(0);
			_uints      = new HashTable(0);
			_doubles    = new HashTable(0);
			_strings    = new HashTable(0);
			_namespaces = new HashTable(0);
			_nssets     = new HashTable(0);
			_multinames = new HashTable(0);
		}
		
		private static function addItem(val:*, table:HashTable):uint
		{
			var index:uint = table.read(val);
			if (index == 0)
			{
				index = table.size + 1;
				table.write(val, index);
			}
			return index;
		}
		
		public function int32(val:int):uint 
		{
			if (val == 0) return 0;
			return addItem(val, _ints);
		}
		
		public function uint32(val:uint):uint 
		{
			if (val == 0) return 0;
			return addItem(val, _uints);
		}
		
		public function float64(val:Number):uint 
		{
			if (isNaN(val)) return 0;
			return addItem(val, _doubles);
		}
		
		public function utf8(val:String):uint 
		{
			if (val == "" || !val) return 0;
			return addItem(val, _strings);
		}
		
		/**
		 * @author Tamarin Project, modified slightly
		 */
		public function utf8length(s:String):uint
		{
			var limit:uint = s.length;
			
			for (var i:uint = 0; i < limit && s.AS3::charCodeAt(i) < 128 ; i++) {}
			
			if (i == limit)
				return limit;
			
			var b:AbcByteStream = new AbcByteStream();
			b.utf8(s);
			return b.length;
		}
		
		public function namespaceset(val:AvmNamespaceSet):uint 
		{
			return addItem(val, _nssets);
		}
		
		public function namespace_(val:AvmNamespace):uint
		{
			return addItem(val, _namespaces);
		}
		
		public function multiname(val:IMultiname):uint
		{
			if (val.equalTo(MULTINAME_DEFAULT)) return 0;
			return addItem(val, _multinames);
		}
		
		private function sortObjects(table:HashTable):Array
		{
			
		}
		
		public function serialize(abc:AbcFile):AbcByteStream
		{
			var bytes:AbcByteStream = new AbcByteStream();
			
			// Multinames, namespaces, and nssets have to be written first
			// to make sure the indexes (primitive types) they reference exist.
			
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
			
			/***** INTS ****/
			bytes.uint30(_intIdx.length + 1);
			for each(var i:int in _intIdx)
				bytes.int32(i);
			
			/***** UINTS ****/
			bytes.uint30(_uintIdx.length + 1);
			for each(var u:uint in _uintIdx)
				bytes.uint32(u);
			
			/***** DOUBLES ****/
			bytes.uint30(_doubleIdx.length + 1);
			for each(var d:Number in _doubleIdx)
				bytes.float64(d);
			
			/***** STRINGS ****/
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
			
			return bytes;
		}
	}
}
