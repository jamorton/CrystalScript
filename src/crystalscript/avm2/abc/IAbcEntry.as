package crystalscript.avm2.abc 
{
	
	/**
	 * Interface for all Abc elements
	 * @author Jon Morton
	 */
	public interface IAbcEntry 
	{
		function serialize(bytes:AbcByteStream):void;	
	}
	
}
