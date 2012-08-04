package com.funbuilder.controller.signals
{
	import away3d.entities.Mesh;
	
	import org.osflash.signals.Signal;
	
	public class MouseOutBlockRequest extends Signal
	{
		public function MouseOutBlockRequest()
		{
			super( Mesh );
		}
	}
}