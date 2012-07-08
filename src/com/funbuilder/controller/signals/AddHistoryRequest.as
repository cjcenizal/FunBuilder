package com.funbuilder.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class AddHistoryRequest extends Signal
	{
		public function AddHistoryRequest()
		{
			super( Boolean );
		}
	}
}