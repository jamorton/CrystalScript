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
			
			//var source:String = "loop a = random() if a == 5 and (b + 6) < 5 a = b + 6 end end";
			
			var tok:Tokenizer = new Tokenizer();
			tok.source = "loop a = 5 end";
			trace(tok.scan());
			
			var parser:Parser = new Parser("a = random() while a < 5 a = 5 end");
			parser.parse().toString();
			
			
			/*
			
			var source:String = "loop \n  a = random() \n  if a == 5 and b == 6 \n  a = b + 6 \n  end \n  end";
			var parse:Parser = new Parser(source);
			parse.parse();
			
			trace(parse.tree.toString());
			*/
		}
	}
}
