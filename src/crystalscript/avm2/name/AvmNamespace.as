package crystalscript.avm2.name 
{
	import crystalscript.etc.IHashable;
	import crystalscript.etc.Util;
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmNamespace implements IHashable
	{
		
		public var kind:uint;
		public var name:String;
		
		public function AvmNamespace(kind_:uint, name_:String = "*") 
		{
			kind = kind_;
			name = name_;
		}
		
		public function hash():uint 
		{
			return Util.mixHash(kind, Util.hashString(name));
		}
		
		public function equalTo(val:AvmNamespace):Boolean 
		{
			return val.kind == kind && val.name == name;
		}
		
	}
	
}
