package crystalscript.avm2.name 
{
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmMultiname implements IMultiname
	{
		public var name:String;
		public var nsset:AvmNamespaceSet;
		
		public function AvmMultiname(name_:String, nsset_:AvmNamespaceSet) 
		{
			name  = name_;
			nsset = nsset_;
		}
		
		public function hash():String 
		{
			return name + "-A-" + nsset.hash();
		}
	}
}
