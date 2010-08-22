package crystalscript.avm2.name 
{
	import crystalscript.avm2.abc.AbcInfo;
	
	function packagedQName(ns:String, name:String):AvmQName
	{
		return AvmQName(name, AvmNamespace(AbcInfo.CONSTANT_PackageNamespace, name));
	}

}