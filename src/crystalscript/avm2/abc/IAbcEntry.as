package crystalscript.avm2.abc 
{
	
	/**
	 * Interface for all Abc elements
	 */
	public interface IAbcEntry 
	{
		function serialize(abc:AbcFile):AbcByteStream;
	}
	
}
