package crystalscript.avm2.name 
{
	import crystalscript.etc.IHashable;
	import crystalscript.avm2.abc.AbcInfo;

	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmMultinameL implements IMultiname
	{
		private var _nsset:AvmNamespaceSet;
		
		public function get kind():uint { return AbcInfo.CONSTANT_MultinameL; }
		
		public function AvmMultinameL(nsset:AvmNamespaceSet) 
		{
			_nsset = nsset;
		}
		
		public function hash():uint 
		{
			return _nsset.hash();
		}
		
		public function equalTo(val:*):Boolean 
		{
			if (!(val is AvmMultinameL)) return false;
			return _nsset.equalTo(val.nsset);
		}
		
		public function get nsset():AvmNamespaceSet { return _nsset; }
		
		public function set nsset(value:AvmNamespaceSet):void 
		{
			_nsset = value;
		}
	}
}
