package crystalscript.avm2.name 
{
	import crystalscript.etc.IHashable;
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmRTQNameL implements IMultiname, IHashable
	{

		public function AvmRTQNameL()
		{
		}
		
		public function hash():uint 
		{
			return 1;
		}
		
		public function equalTo(val:AvmRTQNameL):Boolean 
		{
			return true;
		}
	}
}
