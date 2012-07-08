package com.funbuilder.controller.signals
{
	import com.funbuilder.model.vo.HistoryVO;
	
	import org.osflash.signals.Signal;
	
	public class AddHistoryRequest extends Signal
	{
		public function AddHistoryRequest()
		{
			super( HistoryVO );
		}
	}
}