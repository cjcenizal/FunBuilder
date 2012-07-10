package com.funbuilder.controller.signals
{
	import away3d.controllers.HoverController;
	
	import org.osflash.signals.Signal;
	
	public class AddCameraControllerRequest extends Signal
	{
		public function AddCameraControllerRequest()
		{
			super( HoverController );
		}
	}
}