package com.funbuilder.model.vo
{
	import com.funrun.model.vo.BlockVo;
	
	import flash.display.Bitmap;

	public class AddItemToLibraryVo
	{
		
		public var block:BlockVo;
		public var bitmap:Bitmap;
		
		public function AddItemToLibraryVo( block:BlockVo, bitmap:Bitmap )
		{
			this.block = block;
			this.bitmap = bitmap;
		}
	}
}