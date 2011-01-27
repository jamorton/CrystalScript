package crystalscript.etc 
{
	
	public class HashTable 
	{
		private var _hashFunc:Function;
		private var _eqFunc:Function;
		private var _default:*;
		
		private var _table:Vector.<HashEntry>;
		private var _length:uint;
		private var _size:uint;
		
		private var _divisor:uint;
		
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
			_size = 2;
			_length = 0;
			_divisor = _size - 1;
			_table = makeTable();
		}
		
		public function read(key:*):*
		{
			var c:uint = hash(key) & _divisor;
			var entry:HashEntry = _table[c];
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
			if (_length >= _size)
				rehash();
			var h:uint = hash(key);
			var c:uint = h & _divisor;
			var entry:HashEntry = new HashEntry(key, h, val);
			insert(entry, c);
			_length++;
			
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
			newEntry.prev = list;
		}
		
		public function toArray():Array 
		{
			var i:uint, k:uint, j:uint, l:uint;
			var arr:Array = new Array();
			for (i = 0, k = _size; i < k; i++)
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
		
		private function rehash():void 
		{
			var k:uint = _size;
			_divisor = (_size <<= 1) - 1;
			var newtable:Vector.<HashEntry> = makeTable();
			for each(var i:uint = 0; i < k; i++) 
			{
				var entry:HashEntry = _table[i];
				if (entry != null)
					newtable[entry.hash & _divisor] = entry;
			}
			_table = newtable;
		}
		
		private function makeTable():Vector.<HashEntry> 
		{
			return new Vector.<HashEntry>(_size);
		}
		
		public function get length():uint { return _length; }
	}
	
}

internal class HashEntry 
{
	public var key:*;
	public var hash:uint;
	public var value:*;
	
	public var next:HashEntry;
	public var prev:HashEntry;
	
	function HashEntry(k:*, h:*, v:*, n:HashEntry = null, p:HashEntry = null)
	{
		key   = k;
		hash  = h;
		value = v;
		next  = n;
		prev  = p;
	}
	
}

