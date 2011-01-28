package crystalscript
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import crystalscript.avm2.abc.*;
	import crystalscript.avm2.name.*;
	import crystalscript.base.*;
	import crystalscript.parser.*;
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			// test avm2
			var cp:AbcConstantPool = new AbcConstantPool();
			
			var ns:AvmNamespace = new AvmNamespace("beep", AbcInfo.CONSTANT_PackageNamespace);
			var name:AvmQName = new AvmQName("test", ns);
			
			var name2:AvmRTQName = new AvmRTQName("foo");
			
			var nsset:AvmNamespaceSet = new AvmNamespaceSet();
			nsset.add(new AvmNamespace("barbaz", AbcInfo.CONSTANT_PackageNamespace));
			nsset.add(new AvmNamespace("beef", AbcInfo.CONSTANT_PackageNamespace));
			nsset.add(new AvmNamespace("Sprite", AbcInfo.CONSTANT_PackageNamespace));
			var mn:AvmMultiname = new AvmMultiname("MyMultiname", nsset);

			cp.int32(0xBEEF);
			cp.float64(69.42);
			cp.uint32(0xDEAD);
			cp.utf8("TEST UTF8 WOO!");
			cp.multiname(name2);		
			cp.multiname(name);
			cp.multiname(mn);
			
			trace(cp.serialize(new AbcFile()).hexDump());
			
			
			// test parser
			
			/*
			var parser:Parser = new Parser("while a and (b > (b + c + d)) and f call() if a > 6 call2() end end");
			parser.parse();
			trace(parser.tree.toString());
			*/
		}
	}
}
