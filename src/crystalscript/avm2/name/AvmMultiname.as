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
		private var _nsset:AvmNamespaceSet;
		
		public function AvmMultiname(name:String, nsset:AvmNamespaceSet) 
		{
			_name  = name;
			_nsset = nsset;
		}
		
		public function hash():uint 
		{
			return Util.mixHash(Util.hashString(_name), nsset.hash());
		}
		
		public function equalTo(val:*):Boolean 
		{
			if (!(val is AvmMultiname)) return false;
			return _name == val.name && _nsset.equalTo(val.nsset);
		}
		
		public function get kind():uint { return AbcInfo.CONSTANT_Multiname; }
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get nsset():AvmNamespaceSet { return _nsset; }
		
		public function set nsset(value:AvmNamespaceSet):void 
		{
			_nsset = value;
		}
	}
}
