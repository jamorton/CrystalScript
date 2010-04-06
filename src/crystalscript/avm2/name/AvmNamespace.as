package crystalscript.avm2.name 
{
	import crystalscript.etc.IHashable;
	import crystalscript.etc.Util;
	import crystalscript.avm2.abc.AbcInfo;

	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmNamespace implements IHashable
	{
		
		public var kind:uint;
		public var name:String;
		
		public const KIND:uint = AbcInfo.CONSTANT_Namespace;
		
		public function AvmNamespace(kind_:uint, name_:String = "*") 
		{
			kind = kind_;
			name = name_;
		}
		
		public function hash():uint 
		{
			return Util.mixHash(kind, Util.hashString(name));
		}
		
		public function equalTo(val:*):Boolean 
		{
			return val.kind == kind && val.name == name;
		}
		
	}
	
}
