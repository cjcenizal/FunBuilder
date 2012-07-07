package com.funbuilder.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class ShowStatsRequest extends Signal
	{
		public function ShowStatsRequest()
		{
			super( Boolean );
		}
	}
}