package crystalscript.base 
{
	
	/**
	 * A simple, relatively efficient hash table implementation designed to be
	 * extremely flexible.
	 * 
	 * Comparison to builtin solutions: AS3's Object does not work well with
	 * non-primitive types as keys, and the Dictionary class is purel reference
	 * based. This hash table allows for custom hash and equality functions,
	 * which makes it much more flexible.
	 * 
	 * If a given key is a primitive type, it will be automatically hashed. If 
	 * a key is an arbitrary object, it is expected to implement IHashable.
	 */
	public class HashTable 
	{
		private var _default:*;
		
		private var _table:Vector.<HashEntry>;
		private var _numItems:uint;
		
		private static const MAX_LOAD_FACTOR:Number = 0.75;
		
		public function HashTable(def:* = null) 
		{
			_default  = def;
			_table    = new Vector.<HashEntry>(11);
			_numItems = 0;
		}
		
		public function read(key:*):*
		{
			var entry:HashEntry = _table[hash(key) % _table.length];
			while (entry)
			{
				if (eq(key, entry.key))
					return entry.value;
				entry = entry.next;
			}
			return _default;
		}
		
		public function write(key:*, val:*):void
		{
			if (loadFactor >= MAX_LOAD_FACTOR)
				resize();
			var h:uint = hash(key);
			var entry:HashEntry = new HashEntry(key, h, val);
			insert(entry, h % _table.length);
			_numItems++;
		}
		
		private function insert(newEntry:HashEntry, h:uint):void
		{
			if (_table[h] == null)
			{
				_table[h] = newEntry;
				return;
			}
			var list:HashEntry = _table[h];
			while (list)
			{
				if (eq(list.key, newEntry.key))
					return;
				list = list.next;
			}
			list.next = newEntry;
		}
		
		private function eq(elem1:*, elem2:*):Boolean
		{
			if (elem1 is IHashable) return elem1.equalTo(elem2);
			return elem1 == elem2;
		}
		
		private function hash(elem:*):uint 
		{
			if (elem is IHashable) return elem.hash();
			return Util.hash(elem);
		}
		
		private function resize():void 
		{
			var oldTable:Vector.<HashEntry> = _table;
			_table = new Vector.<HashEntry>(_table.length * 2 + 1);
			for(var i:uint = 0, k:uint = oldTable.length; i < k; i++) 
			{
				var entry:HashEntry = oldTable[i];
				insert(entry, entry.hash % _table.length);
			}
		}
		
		public function toArray():Array 
		{
			var i:uint, k:uint, j:uint, l:uint;
			var arr:Array = new Array();
			for (i = 0, k = _table.length; i < k; i++)
			{
				var list:HashEntry = _table[i];
				while (list)
				{
					arr.push( { "key": list.key, "value": list.value, "hash": list.hash } );
					list = list.next;
				}
			}
			return arr;
		}
		
		public function get loadFactor():Number
		{
			return _numItems / _table.length;
		}
		
		public function get size():uint { return _numItems; }
	}
	
}

/**
 * An instance of this internal class is created for each
 * entry into the table. It's main purpose is to keep
 * track of a key's hash so that it does not need to be
 * recalculated when the table is resized. It also functions
 * as a linked list node for chaining.
 */
internal class HashEntry
{
	public var key:*;
	public var hash:uint;
	public var value:*;
	
	public var next:HashEntry;
	
	function HashEntry(k:*, h:*, v:*, n:HashEntry = null)
	{
		key   = k;
		hash  = h;
		value = v;
		next  = n;
	}
	
}

