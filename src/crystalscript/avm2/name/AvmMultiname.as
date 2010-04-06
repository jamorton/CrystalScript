package crystalscript.avm2.name 
{
	import crystalscript.avm2.abc.AbcInfo;
	import crystalscript.etc.IHashable;
	import crystalscript.etc.Util;

	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmMultiname implements IMultiname, IHashable
	{
		public var name:String;
		public var nsset:AvmNamespaceSet;
		
		public const KIND:uint = AbcInfo.CONSTANT_Multiname;
		
		public function AvmMultiname(name_:String, nsset_:AvmNamespaceSet) 
		{
			name  = name_;
			nsset = nsset_;
		}
		
		public function hash():uint 
		{
			return Util.mixHash(Util.hashString(name), nsset.hash());
		}
		
		public function equalTo(val:*):Boolean 
		{
			if (!(val is AvmMultiname)) return false;
			return name == val.name && nsset.equalTo(val.nsset);
		}
	}
}
