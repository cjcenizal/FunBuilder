package com.funbuilder.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class ShowSelectionIndicatorRequest extends Signal
	{
		public function ShowSelectionIndicatorRequest()
		{
			super( Boolean );
		}
	}
}