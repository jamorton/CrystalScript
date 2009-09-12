package crystalscript.avm2.name 
{
	import crystalscript.etc.IHashable;
	import crystalscript.etc.Util;
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmRTQName implements IMultiname, IHashable
	{
		public var name:String;
		
		public function AvmRTQName(name_:String) 
		{
			name  = name_;
		}
		
		public function hash():uint 
		{
			return Util.hashString(name);
		}
		
		public function equalTo(val:AvmRTQName):Boolean 
		{
			return name == val.name;
		}
	}
}
