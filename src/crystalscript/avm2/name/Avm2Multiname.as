package crystalscript.avm2.name 
{
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class Avm2Multiname 
	{
		
		public var kind:uint = 0;
		public var name:uint = 0;
		public var ns:uint   = 0; // either index to namespaces, index to namespacessets, or n/a
		
		public function Avm2Multiname(tkind:uint, tname:uint, tns:uint) 
		{
			kind = tkind;
			name = tname;
			ns   = tns;
		}
		
		public function hash():String 
		{
			// Laame.
			return tkind + "." + name + "." + ns;
		}
	}
}
