package crystalscript.avm2.name 
{
	import crystalscript.etc.IHashable;
	import crystalscript.avm2.abc.AbcInfo;

	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmMultinameL implements IMultiname, IHashable
	{
		public var nsset:AvmNamespaceSet;
		
		public const KIND:uint = AbcInfo.CONSTANT_MultinameL;
		
		public function AvmMultinameL(nsset_:AvmNamespaceSet) 
		{
			nsset = nsset_;
		}
		
		public function hash():uint 
		{
			return nsset.hash();
		}
		
		public function equalTo(val:*):Boolean 
		{
			if (!(val is AvmMultinameL)) return false;
			return val.nsset.equalTo(val.nsset);
		}
	}
}
