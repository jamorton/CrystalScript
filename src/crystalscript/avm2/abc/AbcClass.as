package crystalscript.avm2.abc 
{
	import crystalscript.avm2.name.*;

	public class AbcClass extends EntryFlags implements IAbcEntry
	{
		
		// from Adobe AVM2 overview, section 4.7
		private static const CONSTANT_ClassSealed:uint      = 0x01;
		private static const CONSTANT_ClassFinal:uint       = 0x02;
		private static const CONSTANT_ClassInterface:uint   = 0x04;
		private static const CONSTANT_ClassProtectedNs:uint = 0x08;
		
		private var _name:AvmQName;
		private var _superName:IMultiname;
		private var _protectedNs:IMultiname;
		private var _interfaces:Vector.<IMultiname>;
		
		public function AbcClass(name:AvmQName)
		{
			_name = name;
			_superName = null;
			_protectedNs = null;
			_interfaces = new Vector.<IMultiname>();
		}
		
		public function serialize(abc:AbcFile):AbcByteStream
		{
			var bytes:AbcByteStream = new AbcByteStream();
			
			return bytes;
		}
		
		////////////////////////////////////////////////////////////////////////
		// FLAGS PROPERTIES
		////////////////////////////////////////////////////////////////////////
		
		public function get isSealed():Boolean { return getFlagBit(CONSTANT_ClassSealed); }
		public function set isSealed(value:Boolean):void { setFlagBit(CONSTANT_ClassSealed, value); }
		
		public function get isFinal():Boolean { return getFlagBit(CONSTANT_ClassFinal); }
		public function set isFinal(value:Boolean):void { setFlagBit(CONSTANT_ClassFinal, value); }
		
		public function get isInterface():Boolean { return getFlagBit(CONSTANT_ClassInterface); }
		public function set isInterface(value:Boolean):void { setFlagBit(CONSTANT_ClassInterface, value); }
		
		////////////////////////////////////////////////////////////////////////
		// ENTRY PROPERTIES
		////////////////////////////////////////////////////////////////////////
		
		public function get superName():IMultiname { return _superName; }
		
		public function set superName(value:IMultiname):void 
		{
			_superName = value;
		}
		
		public function get protectedNs():IMultiname { return _protectedNs; }
		
		public function set protectedNs(value:IMultiname):void 
		{
			if (value == null)
				setFlagBit(CONSTANT_ClassProtectedNs, false);
			else
				setFlagBit(CONSTANT_ClassProtectedNs, true);
			_protectedNs = value;
		}
		
		public function get interfaces():Vector.<IMultiname> { return _interfaces; }
	}

}