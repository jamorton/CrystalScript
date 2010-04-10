package crystalscript
{
	import crystalscript.etc.HashTable;
	import crystalscript.etc.Util;
	import crystalscript.parser.Parser;
	import crystalscript.parser.Token;
	import crystalscript.parser.Tokenizer;
	import crystalscript.parser.TokenType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import crystalscript.avm2.abc.*;
	import crystalscript.avm2.name.*;
	
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
			
			/*
			var cp:AbcConstantPool = new AbcConstantPool();
			
			var ns:AvmNamespace = new AvmNamespace(AbcInfo.CONSTANT_PackageNamespace, "poop");
			var name:AvmQName = new AvmQName("test", ns);
			
			var name2:AvmRTQName = new AvmRTQName("foo");
			
			var nsset:AvmNamespaceSet = new AvmNamespaceSet();
			nsset.add(new AvmNamespace(AbcInfo.CONSTANT_PackageNamespace, "poop"));
			nsset.add(new AvmNamespace(AbcInfo.CONSTANT_PackageNamespace, "beef"));
			nsset.add(new AvmNamespace(AbcInfo.CONSTANT_PackageNamespace, "Sprite"));
			var mn:AvmMultiname = new AvmMultiname("MyMultiname", nsset);

			cp.int32(0xBEEF);
			cp.float64(69.42);
			cp.uint32(0xDEAD);
			cp.utf8("TEST UTF8 WOO!");
			cp.multiname(name2);		
			cp.multiname(name);
			cp.multiname(mn);
			
			var file:AbcFile = new AbcFile();
			file.constantPool = cp;
			
			trace(file.serialize().hexDump());
			*/
			
			var source:String = "loop\na = random()\nif a == 5\na = b + 6\nend\nend";
			var parse:Parser = new Parser(source);
			
			var tok:Tokenizer = new Tokenizer(source);
			for each(var t:Token in tok.scan())
				trace(t.type + " - " + t.value);
			
			trace(parse.tree.toString());
		}
	}
}
