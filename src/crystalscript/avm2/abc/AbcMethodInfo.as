package crystalscript.avm2.abc 
{
	
	public class AbcMethodInfo implements IAbcEntry
	{
		
		public function AbcMethodInfo() 
		{
			
		}
		
		
		public function serialize():AbcByteStream 
		{
			return new AbcByteStream();
		}
		
	}
	
}
