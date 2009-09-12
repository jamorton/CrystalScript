package crystalscript.avm2.name 
{
	import crystalscript.etc.IHashable;
	import crystalscript.etc.Util;
	import crystalscript.avm2.abc.AbcInfo;

	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmRTQName implements IMultiname, IHashable
	{
		public var name:String;
		
		public const KIND:uint = AbcInfo.CONSTANT_RTQname;
		
		public function AvmRTQName(name_:String) 
		{
			name  = name_;
		}
		
		public function hash():uint 
		{
			return Util.hashString(name);
		}
		
		public function equalTo(val:*):Boolean 
		{
			if (!(val is AvmRTQName)) return false;
			return name == val.name;
		}
	}
}
