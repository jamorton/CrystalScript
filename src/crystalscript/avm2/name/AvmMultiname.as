package crystalscript.avm2.name 
{
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
		
		public function AvmMultiname(name_:String, nsset_:AvmNamespaceSet) 
		{
			name  = name_;
			nsset = nsset_;
		}
		
		public function hash():uint 
		{
			return Util.mixHash(Util.hashString(name), nsset.hash());
		}
		
		public function equalTo(val:AvmMultiname):Boolean 
		{
			return name == val.name && nsset.equalTo(val.nsset);
		}
	}
}
