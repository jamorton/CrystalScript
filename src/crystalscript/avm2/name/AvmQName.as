package crystalscript.avm2.name 
{
	import crystalscript.etc.IHashable;
	import crystalscript.etc.Util;
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmQName implements IMultiname, IHashable
	{
		
		public var name:String;
		public var ns:AvmNamespace;
		
		public function AvmQName(name_:String, ns_:AvmNamespace) 
		{
			name  = name_;
			ns = ns_;
		}
		
		public function hash():uint
		{
			// Very arbitray.
			return Util.mixHash(Util.hashString(name), ns.hash());
		}
		
		public function equalTo(val:AvmQName):Boolean 
		{
			return val.name == name && val.ns.equalTo(ns);
		}
	}
	
}
