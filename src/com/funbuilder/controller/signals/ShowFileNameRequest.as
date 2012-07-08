package com.funbuilder.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class ShowFileNameRequest extends Signal
	{
		public function ShowFileNameRequest()
		{
			super(String);
		}
	}
}