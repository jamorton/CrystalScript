package crystalscript.avm2.name 
{
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmNamespace 
	{
		
		public var kind:uint;
		public var name:String;
		
		public function AvmNamespace(kind_:uint, name_:String = "*") 
		{
			kind = kind_;
			name = name_;
		}
		
		public function hash():String 
		{
			return kind + "." + name;
		}
		
	}
	
}
