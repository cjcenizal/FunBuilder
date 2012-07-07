package com.funbuilder.controller.signals
{
	import away3d.entities.Mesh;
	
	import org.osflash.signals.Signal;
	
	public class AddBlockToSegmentRequest extends Signal
	{
		public function AddBlockToSegmentRequest()
		{
			super( Mesh );
		}
	}
}