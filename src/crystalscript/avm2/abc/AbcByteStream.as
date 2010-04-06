package crystalscript.avm2.abc 
{
	import crystalscript.etc.Util;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * @see AbcByteStream in ESC sources (http://hg.mozilla.org/tamarin-redux/)
	 * @author Jon Morton, Adobe
	 */
	public class AbcByteStream 
	{
		
		private var _bytes:ByteArray;
		
		public function AbcByteStream() 
		{
			_bytes = new ByteArray();
			_bytes.position = 0;
			_bytes.endian = Endian.LITTLE_ENDIAN;
		}
		
		public function uint8(m:uint):void
		{
			Util.assert(m < 256);
			_bytes.writeByte(m);
		}
		
		public function uint16(m:uint):void
		{
			Util.assert(m < 65536);
			bytes.writeByte (m & 0xFF);
			bytes.writeByte ((m >> 8) & 0xFF);
		}
		
		public function int16(m:int):void
		{
			Util.assert(-32768 <= m && m < 32768);
			bytes.writeByte (m & 0xFF);
			bytes.writeByte ((m >> 8) & 0xFF);
		}
		
		public function int24(m:int):void
		{
			Util.assert(-16777216 <= m && m < 16777216);
			bytes.writeByte (m & 0xFF);
			bytes.writeByte ((m >> 8) & 0xFF);
			bytes.writeByte ((m >> 16) & 0xFF);
		}
		
		public function uint30(m:uint):void
		{
			Util.assert(m < 1073741824);
			uint32(m);
		}
		
		public function int30(m:int):void
		{
			Util.assert(-1073741824 <= m && m < 1073741824);
			if (m < 0)
				uint32(-m);
			else
				uint32(uint(m));
		}
		
		public function int32(m:int):void
		{
			uint32(uint(m));
		}
		
		public function float64(m:Number):void
		{
			_bytes.writeDouble(m);
		}
		
		public function utf8(m:String):void
		{
			_bytes.writeUTFBytes(m);
		}
		
		public function addBytes(m:AbcByteStream):void 
		{
			_bytes.writeBytes(m.bytes);
		}
		
		/**
		 * @author Adobe (http://hg.mozilla.org/tamarin-redux/raw-file/0244f48c3ce1/esc/src/bytes-tamarin.es)
		 */
		public function uint32(val:uint):void
		{
			if (val < 0x80)
			{
				// 7 bits
				_bytes.writeByte (val & 0x7F);
			}
			else if (val < 0x4000)
			{
				// 14 bits
				_bytes.writeByte ((val & 0x7F) | 0x80);
				_bytes.writeByte ((val >> 7) & 0x7F);
			}
			else if (val < 0x200000)
			{
				// 21 bits
				_bytes.writeByte ((val & 0x7F) | 0x80);
				_bytes.writeByte (((val >> 7) & 0x7F) | 0x80);
				_bytes.writeByte ((val >> 14) & 0x7F);
			}
			else if (val < 0x10000000)
			{
				// 28 bits
				_bytes.writeByte ((val & 0x7F) | 0x80);
				_bytes.writeByte (((val >> 7) & 0x7F) | 0x80);
				_bytes.writeByte (((val >> 14) & 0x7F) | 0x80);
				_bytes.writeByte ((val >> 21) & 0x7F);
			}
			else
			{
				// 32 bits
				_bytes.writeByte ((val & 0x7F) | 0x80);
				_bytes.writeByte (((val >> 7) & 0x7F) | 0x80);
				_bytes.writeByte (((val >> 14) & 0x7F) | 0x80);
				_bytes.writeByte (((val >> 21) & 0x7F) | 0x80);
				_bytes.writeByte ((val >> 28) & 0x7F);
			}
		}
		
		
		public function toString():String 
		{
			return _bytes.toString();
		}
		
		public function get bytes():ByteArray { return _bytes; }
		public function get length():uint { return _bytes.length; }
		
		public function get position():uint { return _bytes.position }
		public function set position(val:uint):void { _bytes.position = val };
	}
	
}
