package crystalscript.avm2.abc
{
	
	/**
	 * Random information
	 * @author Jon Morton
	 */
	public class AbcInfo 
	{
		
		// TODO: move this out of here and split it up
		
		// ABC File version info
		public static const MINOR_VERSION:uint = 16;
		public static const MAJOR_VERSION:uint = 46;
		
		
		public static const CONSTANT_Void:uint                = 0x00;
		public static const CONSTANT_Utf8:uint                = 0x01;
		public static const CONSTANT_Decimal:uint             = 0x02;
		public static const CONSTANT_Integer:uint             = 0x03;
		public static const CONSTANT_UInteger:uint            = 0x04;
		public static const CONSTANT_PrivateNamespace:uint    = 0x05;
		public static const CONSTANT_Double:uint              = 0x06;
		public static const CONSTANT_QName:uint               = 0x07;
		public static const CONSTANT_Namespace:uint           = 0x08;
		public static const CONSTANT_Multiname:uint           = 0x09;
		public static const CONSTANT_False:uint               = 0x0A;
		public static const CONSTANT_True:uint                = 0x0B;
		public static const CONSTANT_Null:uint                = 0x0C;
		public static const CONSTANT_QNameA:uint              = 0x0D;
		public static const CONSTANT_MultinameA:uint          = 0x0E;
		public static const CONSTANT_RTQName:uint             = 0x0F;
		public static const CONSTANT_RTQNameA:uint            = 0x10;
		public static const CONSTANT_RTQNameL:uint            = 0x11;
		public static const CONSTANT_RTQNameLA:uint           = 0x12;
		public static const CONSTANT_NamespaceSet:uint       = 0x15;
		public static const CONSTANT_PackageNamespace:uint    = 0x16;
		public static const CONSTANT_PackageInternalNs:uint   = 0x17;
		public static const CONSTANT_ProtectedNamespace:uint  = 0x18;
		public static const CONSTANT_ExplicitNamespace:uint   = 0x19;
		public static const CONSTANT_StaticProtectedNs:uint   = 0x1A;
		public static const CONSTANT_MultinameL:uint          = 0x1B;
		public static const CONSTANT_MultinameLA:uint         = 0x1C;
		public static const CONSTANT_TypeName:uint            = 0x1D;


	}
}
