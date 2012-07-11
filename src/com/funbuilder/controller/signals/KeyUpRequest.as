package com.funbuilder.controller.signals
{
	import flash.events.KeyboardEvent;
	
	import org.osflash.signals.Signal;
	
	public class KeyUpRequest extends Signal
	{
		public function KeyUpRequest()
		{
			super( KeyboardEvent );
		}
	}
}