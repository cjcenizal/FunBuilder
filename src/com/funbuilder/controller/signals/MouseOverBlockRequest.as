package com.funbuilder.controller.signals
{
	import away3d.entities.Mesh;
	
	import org.osflash.signals.Signal;
	
	public class MouseOverBlockRequest extends Signal
	{
		public function MouseOverBlockRequest()
		{
			super( Mesh );
		}
	}
}