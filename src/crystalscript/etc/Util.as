package crystalscript.etc 
{

	import flash.accessibility.Accessibility;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	public class Util {
		
		
		
		public static function getClassName(o:Object):String
		{
			var fullClassName:String = getQualifiedClassName(o);
			
			var a:ByteArray = new ByteArray();
			
			return fullClassName.slice(fullClassName.lastIndexOf("::") + 1);
		}
		
		
		public static function assert(test:Boolean, extra:String = "(no info)"):void 
		{
			if (!test)
				throw new Error("Assertion failed: " + extra);
		}
		
		
		/**
		 * @author  creynders (http://www.actionscript.org/forums/showthread.php3?t=158117)
		 * @param	obj
		 * @param	level
		 */

		public static function deepTrace(obj:*, level:int = 0):void
		{
			var clname:String = getClassName(obj);
					
			var tabs:String = "";
			for ( var i:int = 0; i < level ; i++, tabs += "\t" );
			
			if (clname == "Array") {
				trace(tabs + clname);
				trace(tabs + "(");
			}
			
			for ( var prop:String in obj ){
				trace( "\t" + tabs + "[" + prop + "] -> " + obj[prop] );
				deepTrace( obj[prop], level + 1 );
			}
			
			if (clname == "Array") {
				trace(tabs + ")");
			}
		}
	
	}
	
}
