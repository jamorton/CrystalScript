package crystalscript.avm2.name 
{
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmMultinameL implements IMultiname
	{
		public var nsset:AvmNamespaceSet;
		
		public function AvmMultinameL(nsset_:AvmNamespaceSet) 
		{
			nsset = nsset_;
		}
		
		public function hash():String 
		{
			return "-B-" + nsset.hash();
		}
	}
}
