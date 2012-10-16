package com.funbuilder.model.vo
{
	import com.funrun.model.vo.BlockTypeVo;
	
	import flash.display.Bitmap;

	public class AddItemToLibraryVo
	{
		
		public var block:BlockTypeVo;
		public var bitmap:Bitmap;
		
		public function AddItemToLibraryVo( block:BlockTypeVo, bitmap:Bitmap )
		{
			this.block = block;
			this.bitmap = bitmap;
		}
	}
}