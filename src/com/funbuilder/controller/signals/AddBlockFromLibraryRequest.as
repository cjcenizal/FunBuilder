package com.funbuilder.controller.signals
{
	import org.osflash.signals.Signal;
	
	public class AddBlockFromLibraryRequest extends Signal
	{
		public function AddBlockFromLibraryRequest()
		{
			super( String );
		}
	}
}