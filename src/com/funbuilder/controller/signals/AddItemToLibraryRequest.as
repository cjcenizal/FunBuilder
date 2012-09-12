package com.funbuilder.controller.signals
{
	import com.funbuilder.model.vo.AddItemToLibraryVo;
	
	import org.osflash.signals.Signal;
	
	public class AddItemToLibraryRequest extends Signal
	{
		public function AddItemToLibraryRequest()
		{
			super( AddItemToLibraryVo );
		}
	}
}