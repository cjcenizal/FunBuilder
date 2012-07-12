package com.funbuilder.controller.signals
{
	import com.funbuilder.model.vo.DeselectBlockVO;
	
	import org.osflash.signals.Signal;
	
	public class DeselectBlockRequest extends Signal
	{
		public function DeselectBlockRequest()
		{
			super( DeselectBlockVO );
		}
	}
}