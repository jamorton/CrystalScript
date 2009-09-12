package crystalscript.avm2.name 
{
	
	/**
	 * ...
	 * @author Jon Morton
	 */
	public class AvmRTQName implements IMultiname
	{
		public var name:String;
		
		public function AvmRTQName(name_:String) 
		{
			name  = name_;
		}
		
		public function hash():String 
		{
			return name + "-C-";
		}
	}
}
