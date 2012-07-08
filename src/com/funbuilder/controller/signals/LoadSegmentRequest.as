package com.funbuilder.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class LoadSegmentRequest extends Signal
	{
		public function LoadSegmentRequest()
		{
			super( String );
		}
	}
}