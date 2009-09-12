package crystalscript.avm2.name 
{
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class Avm2NamespaceSet 
	{
		
		private var _namespaces:Vector.<Avm2Namespace>();
		
		public function Avm2NamespaceSet() 
		{
			_namespaces = new Vector.<Avm2Namespace>();
		}
		
		public function hash():String 
		{
			// TODO: This sucks
			var s:String;
			for each(var n:Namespace in _namespaces)
				s += n.hash() + "|";
			return s;
		}
		
		public function add(ns:Avm2Namespace):uint 
		{
			return _namespaces.push(ns) - 1;
		}
		
		public function get length():uint { return _namespaces.length; }
		
		public function get namespaces():Vector.<Avm2Namespace> { return _namespaces; }
		
	}
	
}
