package com.funbuilder.controller.signals
{
	import com.funrun.model.vo.BlockVO;
	
	import org.osflash.signals.Signal;
	
	public class SelectLibraryBlockRequest extends Signal
	{
		public function SelectLibraryBlockRequest()
		{
			super( BlockVO );
		}
	}
}