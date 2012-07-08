package com.funbuilder.controller.signals
{
	import flash.geom.Vector3D;
	
	import org.osflash.signals.Signal;
	
	public class MoveBlockRequest extends Signal
	{
		public function MoveBlockRequest()
		{
			super( Vector3D );
		}
	}
}