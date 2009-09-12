package crystalscript.etc 
{
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public interface IHashable 
	{
		function hash():uint;
		function equalTo(val:*):Boolean;
	}
	
}
