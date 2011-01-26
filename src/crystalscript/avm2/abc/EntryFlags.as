package crystalscript.avm2.abc 
{

	/**
	 * Many entries in ABC files tend to have a flags field that is a simple bit vector.
	 */
	public class EntryFlags
	{
		
		private var _flags:uint;
		
		public function EntryFlags() 
		{
			throw new Error("EntryFlags is abstract and may not be instantiated directly");
		}
		
		private function getFlagBit(bit:uint):Boolean
		{
			return Boolean(_flags & bit);
		}
		
		private function setFlagBit(bit:uint, val:Boolean):void
		{
			if (val) _flags |=  bit;
			else     _flags &= ~bit;
		}
		
		public function get flags():uint { return _flags; }
		
		public function set flags(value:uint):void 
		{
			_flags = value;
		}
		
	}

}