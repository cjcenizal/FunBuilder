package com.funbuilder.controller.signals
{
	import away3d.entities.Mesh;
	
	import org.osflash.signals.Signal;
	
	public class RemoveBlockRequest extends Signal
	{
		public function RemoveBlockRequest()
		{
			super( Mesh );
		}
	}
}