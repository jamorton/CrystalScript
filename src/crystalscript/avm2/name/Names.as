package crystalscript.avm2.name 
{
	import crystalscript.avm2.abc.AbcInfo;
	
	public class Names
	{
		public static function packagedQName(ns:String, name:String):AvmQName
		{
			return new AvmQName(name, AvmNamespace(ns, bcInfo.CONSTANT_PackageNamespace));
		}
		
		public static function any():IMultiname
		{
			return packagedQName("", "*");
		}
	}
}