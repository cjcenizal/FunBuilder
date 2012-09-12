package com.funbuilder.controller.signals
{
	import com.funbuilder.model.vo.DeselectBlockVo;
	
	import org.osflash.signals.Signal;
	
	public class DeselectBlockRequest extends Signal
	{
		public function DeselectBlockRequest()
		{
			super( DeselectBlockVo );
		}
	}
}