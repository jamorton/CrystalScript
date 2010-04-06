package crystalscript.etc 
{
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class HashTable 
	{
		
		
		
		private var _hashFunc:Function;
		private var _eqFunc:Function;
		private var _default:*;
		
		private var _table:Array;
		private var _length:uint;
		private var _size:uint;
		
		private var _divisor:uint;
		
		public function HashTable(hashfunc:Function = null, eqfunc:Function = null, def:* = null) 
		{
			_default  = def;
			_hashFunc = hashfunc;
			_eqFunc   = eqfunc;
			_size = 32;
			_length = 0;
			_divisor = _size - 1;
			_table = makeTable();
		}
		
		public function read(key:*):*
		{
			var list:Array = _table[hash(key) & _divisor];
			var k:uint = list.length;
			var h:uint = hash(key);
			for (var i:uint = 0; i < k; i++) 
			{
				var entry:HashEntry = list[i];
				if (entry.hash == h && eq(key, entry.key))
					return entry.value;
			}
			return _default;
		}
		
		public function write(key:*, val:*):void
		{
			var entry:HashEntry = new HashEntry();
			entry.key = key;
			entry.value = val;
			entry.hash = hash(key);
			_table[entry.hash & _divisor].push(entry);
			_length++;
			if (_length >= _size)
				rehash();
		}
		
		public function toArray():Array 
		{
			var arr:Array = new Array();
			for (var i:uint = 0, k:uint = _length; i < k; i++) 
			{
				var list:Array = _table[i];
				for (var j:uint = 0, l:uint = list.length; j < l; j++) 
				{
					var entry:HashEntry = list[j];
					var m:Object = new Object();
					m["key"] = entry.key;
					m["value"] = entry.value;
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
			_size << 1;
			_divisor = _size - 1;
			var newtable:Array = makeTable();
			for (var i:uint = 0; i < _size; i++) 
			{
				var list:Array = _table[i];
				var k:uint = list.length;
				for (var j:uint = 0; j < k; j++) 
				{
					var entry:HashEntry = list[j];
					newtable[entry.hash & _divisor].push(entry);
				}
			}
			_table = newtable;
		}
		
		private function makeTable():Array 
		{
			var table:Array = new Array();
			for (var i:uint = 0; i < _size; i++) {
				table[i] = new Array();
			}
			return table;
		}
		
		public function get length():uint { return _length; }
	}
	
}

internal class HashEntry 
{
	public var key:*;
	public var hash:*;
	public var value:*;
}

