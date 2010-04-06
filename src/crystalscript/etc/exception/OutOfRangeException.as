package crystalscript.etc.exception 
{
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class OutOfRangeException extends Error
	{	
		public function OutOfRangeException(extra:String = "(no info)") 
		{
			super("Value out of range: " + extra);
		}
	}
}
