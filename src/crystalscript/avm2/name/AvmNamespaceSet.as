package crystalscript.avm2.name 
{
	import crystalscript.etc.Util;
	import crystalscript.avm2.abc.AbcInfo;

	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmNamespaceSet
	{
		
		private var _namespaces:Vector.<AvmNamespace>;
		
		public const KIND:uint = AbcInfo.CONSTANT_Namespace_Set;
		
		public function AvmNamespaceSet() 
		{
			_namespaces = new Vector.<AvmNamespace>();
		}
		
		public function hash():uint 
		{
			var hash:uint = 2166136261;
			for (var i:uint = 0, k:uint = length; i < k; i++) 
			{
				var n:AvmNamespace = _namespaces[i];
				hash = (hash * 16777619) ^ n.hash();
			}
			return hash;
		}
		
		public function equalTo(val:AvmNamespaceSet):Boolean 
		{
			if (length != val.length) return false;
			for (var i:uint = 0, k:uint = length; i < k; i++) 
			{
				if (!_namespaces[i].equalTo(val.namespaces[i])) return false;
			}
			return true;
		}
		
		public function add(ns:AvmNamespace):uint 
		{
			return _namespaces.push(ns) - 1;
		}
		
		public function get length():uint { return _namespaces.length; }
		
		public function get namespaces():Vector.<AvmNamespace> { return _namespaces; }
		
	}
	
}
