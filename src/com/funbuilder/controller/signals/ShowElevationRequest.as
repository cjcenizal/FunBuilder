package com.funbuilder.controller.signals
{
	import flash.geom.Vector3D;
	
	import org.osflash.signals.Signal;
	
	public class ShowElevationRequest extends Signal
	{
		public function ShowElevationRequest()
		{
			super( Vector3D );
		}
	}
}