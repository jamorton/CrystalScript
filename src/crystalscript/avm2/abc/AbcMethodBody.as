package crystalscript.avm2.abc 
{

	public class AbcMethodBody implements IAbcEntry
	{
		
		private var _method:AbcMethodInfo;
		private var _maxStack:uint;
		private var _localCount:uint;
		private var _maxScopeDepth:uint;
		private var _code:AbcByteStream;
		
		public function AbcMethodBody(method:AbcMethodInfo) 
		{
			_method = method;
			_maxStack = 0;
			_localCount = 0;
			_maxScopeDepth = 0;
			_code   = new AbcByteStream();
		}
		
		public function serialize(abc:AbcFile):AbcByteStream
		{
			var bytes:AbcByteStream = new AbcByteStream();
		}
		
		public function get method():AbcMethodInfo { return _method; }
		
		public function get maxStack():uint { return _maxStack; }
		
		public function set maxStack(value:uint):void 
		{
			_maxStack = value;
		}
		
		public function get localCount():uint { return _localCount; }
		
		public function set localCount(value:uint):void 
		{
			_localCount = value;
		}
		
		public function get maxScopeDepth():uint { return _maxScopeDepth; }
		
		public function set maxScopeDepth(value:uint):void 
		{
			_maxScopeDepth = value;
		}
		
		public function get code():AbcByteStream { return _code; }
		
	}

}