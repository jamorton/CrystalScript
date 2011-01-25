package crystalscript.avm2.name 
{
	import crystalscript.etc.IHashable;
	import crystalscript.avm2.abc.AbcInfo;

	public class AvmRTQNameL implements IMultiname
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
			if (!(val is AvmRTQNameL)) return false;
			return true;
		}
		
		public function get kind():uint { return AbcInfo.CONSTANT_RTQNameL; }
	}
}
