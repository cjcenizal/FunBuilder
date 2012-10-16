package com.funbuilder.model.vo
{
	import com.funrun.model.vo.BlockTypeVo;
	
	import flash.display.Bitmap;

	public class AddItemToLibraryVo
	{
		
		public var id:String;
		public var name:String;
		public var bitmap:Bitmap;
		
		public function AddItemToLibraryVo( id:String, name:String, bitmap:Bitmap )
		{
			this.id = id;
			this.name = name;
			this.bitmap = bitmap;
		}
	}
}