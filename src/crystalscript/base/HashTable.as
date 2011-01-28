package crystalscript.base 
{
	
	public class HashTable 
	{
		
		private var _hashFunc:Function;
		private var _eqFunc:Function;
		private var _default:*;
		
		private var _table:Vector.<HashEntry>;
		private var _numItems:uint;
		
		private static const MAX_LOAD_FACTOR:Number = 0.75;
		
		/**
		 * Constructs a new hash table. Functions that hash values to be put into the
		 * table and test for equality between them may be specified. If they are not, it is
		 * expected that all elements put in the table implement IHashable.
		 * 
		 * @param	hashfunc a function which takes an item to be put into the table anre
		 *                   returns a uint hash value
		 * @param	eqfunc   a function which takes two arguments and returns true if they
		 *                   are equal, or false otherwise
		 * @param	def      a default value to return if an item is not found.
		 */
		public function HashTable(hashfunc:Function = null, eqfunc:Function = null, def:* = null) 
		{
			_default  = def;
			_hashFunc = hashfunc;
			_eqFunc   = eqfunc;
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
			if (_eqFunc == null) return elem1.equalTo(elem2);
			return _eqFunc(elem1, elem2);
		}
		
		private function hash(elem:*):uint 
		{
			if (_hashFunc == null) return elem.hash();
			return _hashFunc(elem);
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

