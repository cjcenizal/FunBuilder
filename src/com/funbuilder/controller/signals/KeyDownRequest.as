package com.funbuilder.controller.signals
{
	import flash.events.KeyboardEvent;
	
	import org.osflash.signals.Signal;
	
	public class KeyDownRequest extends Signal
	{
		public function KeyDownRequest()
		{
			super( KeyboardEvent );
		}
	}
}