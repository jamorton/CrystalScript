package crystalscript.avm2.name 
{
	import crystalscript.etc.IHashable;
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmMultinameL implements IMultiname, IHashable
	{
		public var nsset:AvmNamespaceSet;
		
		public function AvmMultinameL(nsset_:AvmNamespaceSet) 
		{
			nsset = nsset_;
		}
		
		public function hash():uint 
		{
			return nsset.hash();
		}
		
		public function equalTo(val:AvmMultinameL):Boolean 
		{
			return val.nsset.equalTo(val.nsset);
		}
	}
}
