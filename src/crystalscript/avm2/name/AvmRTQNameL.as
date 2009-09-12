package crystalscript.avm2.name 
{
	import crystalscript.etc.IHashable;
	import crystalscript.avm2.abc.AbcInfo;
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmRTQNameL implements IMultiname, IHashable
	{

		public const KIND:uint = AbcInfo.CONSTANT_RTQnameL;
		
		public function AvmRTQNameL()
		{
		}
		
		public function hash():uint 
		{
			return 1;
		}
		
		public function equalTo(val:AvmRTQNameL):Boolean 
		{
			if (!(val is AvmRTQNameL)) return false;
			return true;
		}
	}
}
