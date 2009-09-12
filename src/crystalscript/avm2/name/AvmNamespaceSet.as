package crystalscript.avm2.name 
{
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmNamespaceSet 
	{
		
		private var _namespaces:Vector.<AvmNamespace>();
		
		public function AvmNamespaceSet() 
		{
			_namespaces = new Vector.<AvmNamespace>();
		}
		
		public function hash():String 
		{
			var s:String;
			for each(var n:Namespace in _namespaces)
				s += n.hash() + "|";
			return s;
		}
		
		public function add(ns:AvmNamespace):uint 
		{
			return _namespaces.push(ns) - 1;
		}
		
		public function get length():uint { return _namespaces.length; }
		
		public function get namespaces():Vector.<AvmNamespace> { return _namespaces; }
		
	}
	
}
