package crystalscript.avm2.abc 
{
	import crystalscript.avm2.name.IMultiname;
	import crystalscript.avm2.name.Names;
	
	public class AbcMethodInfo extends EntryFlags implements IAbcEntry
	{
	
		//MethodInfo flags, see AVM2 overview, section 4.5
		private static const NEED_ARGUMENTS:uint  = 0x01;
		private static const NEED_ACTIVATION:uint = 0x02;
		private static const NEED_REST:uint       = 0x04;
		private static const HAS_OPTIONAL:uint    = 0x08;
		private static const SET_DXNS:uint        = 0x40;
		private static const HAS_PARAM_NAMES:uint = 0x80;
		
		private var _returnType:IMultiname;
		private var _params:Vector.<IMultiname>;
		private var _optionals:Vector.<Array>;
		private var _name:String;
		
		
		public function AbcMethodInfo()
		{
			_returnType = Names.any();
			_params = new Vector.<IMultiname>();
			_optionals = new Vector.<Array>();
			_name  = "";
			flags  = 0;
		}
		
		public function serialize(abc:AbcFile):AbcByteStream 
		{
			var bytes:AbcByteStream = new AbcByteStream();
			bytes.uint30(paramCount);
			bytes.uint30(abc.pool.multiname(_returnType));
			for each (var param:IMultiname in _params)
				bytes.uint30(abc.pool.multiname(param));
			bytes.uint30(abc.pool.utf8(_name));
			bytes.uint8(flags);
			/*
			 * TODO
			 * 
			if (_optionals.length)
			{
				bytes.uint30(_params.length);
				for (var option:Array in _optionals)
				{
					
				}
			}
			 */
			return bytes;	
		}
		
		public function addOptional(kind:uint, val:* = null):void
		{
			if (_optionals.length == 0)
				setFlagBit(HAS_OPTIONAL, true);
			// this could be done better.
			_optionals.push([kind, val]);
		}
		
		////////////////////////////////////////////////////////////////////////
		// FLAGS PROPERTIES
		////////////////////////////////////////////////////////////////////////
		
		public function get needArguments():Boolean { return getFlagBit(NEED_ARGUMENTS); };
		public function set needArguments(value:Boolean):void
		{
			// needArguments and needRest are mutually exclusive
			if (value == true)
				setFlagBit(NEED_REST, false);
			setFlagBit(NEED_ARGUMENTS, value);
		}
		
		public function get needRest():Boolean { return getFlagBit(NEED_REST); };
		public function set needRest(value:Boolean):void
		{
			// needArguments and needRest are mutually exclusive
			if (value == true)
				setFlagBit(NEED_ARGUMENTS, false);
			setFlagBit(NEED_REST, value);
		}
		
		public function get hasOptional():Boolean { return _optionals.length > 0 }
		
		////////////////////////////////////////////////////////////////////////
		// ENTRY PROPERTIES
		////////////////////////////////////////////////////////////////////////
		
		public function get returnType():IMultiname { return _returnType; }
		
		public function set returnType(value:IMultiname):void 
		{
			_returnType = value;
		}
		
		public function get params():Vector.<IMultiname> { return _params; }
		
		public function get paramCount():int { return _params.length; }
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
	}
	
}
