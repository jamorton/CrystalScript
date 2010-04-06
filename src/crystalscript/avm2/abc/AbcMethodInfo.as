package crystalscript.avm2.abc 
{
	
	/**
	 * ...
	 * @author Jon Morton
	 */
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
