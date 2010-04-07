package crystalscript.avm2.name 
{
	import crystalscript.etc.IHashable;
	import crystalscript.etc.Util;
	import crystalscript.avm2.abc.AbcInfo;

	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmQName implements IMultiname, IHashable
	{
		
		private var _name:String;
		public var ns:AvmNamespace;
		
		public function AvmQName(name:String, ns_:AvmNamespace) 
		{
			_name  = name;
			ns = ns_;
		}
		
		public function hash():uint
		{
			// Very arbitray.
			return Util.mixHash(Util.hashString(_name), ns.hash());
		}
		
		public function equalTo(val:*):Boolean 
		{
			if (!(val is AvmQName)) return false;
			return val.name == name && val.ns.equalTo(ns);
		}
		
		public function get kind():uint { return AbcInfo.CONSTANT_QName; }
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
	}
	
}
