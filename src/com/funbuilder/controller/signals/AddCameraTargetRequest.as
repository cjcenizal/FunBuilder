package com.funbuilder.controller.signals
{
	import away3d.entities.Mesh;
	
	import org.osflash.signals.Signal;
	
	public class AddCameraTargetRequest extends Signal
	{
		public function AddCameraTargetRequest()
		{
			super( Mesh );
		}
	}
}