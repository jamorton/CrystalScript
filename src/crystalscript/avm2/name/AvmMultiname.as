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
		private var _name:String;
		public var nsset:AvmNamespaceSet;
		
		public function AvmMultiname(name_:String, nsset:AvmNamespaceSet) 
		{
			_name  = name;
			this.nsset = nsset;
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
		
		public function get kind():uint { return AbcInfo.CONSTANT_Multiname; }
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
	}
}
