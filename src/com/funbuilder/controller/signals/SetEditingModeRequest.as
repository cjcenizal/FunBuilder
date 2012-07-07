package com.funbuilder.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class SetEditingModeRequest extends Signal
	{
		public function SetEditingModeRequest()
		{
			super( String );
		}
	}
}