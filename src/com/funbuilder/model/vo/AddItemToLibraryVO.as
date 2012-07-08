package com.funbuilder.model.vo
{
	import com.funrun.model.vo.BlockVO;
	
	import flash.display.Bitmap;

	public class AddItemToLibraryVO
	{
		
		public var block:BlockVO;
		public var bitmap:Bitmap;
		
		public function AddItemToLibraryVO( block:BlockVO, bitmap:Bitmap )
		{
			this.block = block;
			this.bitmap = bitmap;
		}
	}
}