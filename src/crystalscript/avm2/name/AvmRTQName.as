package crystalscript.avm2.name 
{
	import crystalscript.etc.IHashable;
	import crystalscript.etc.Util;
	import crystalscript.avm2.abc.AbcInfo;
	
	public class AvmRTQName implements IMultiname
	{
		private var _name:String;
		
		public function AvmRTQName(name:String) 
		{
			_name  = name;
		}
		
		public function hash():uint 
		{
			return Util.hashString(name);
		}
		
		public function equalTo(val:*):Boolean 
		{
			if (!(val is AvmRTQName)) return false;
			return name == val.name;
		}
		
		public function get kind():uint { return AbcInfo.CONSTANT_RTQName; }
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
	}
}
