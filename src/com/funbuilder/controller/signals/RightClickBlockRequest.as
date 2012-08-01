package com.funbuilder.controller.signals
{
	import away3d.entities.Mesh;
	
	import org.osflash.signals.Signal;
	
	public class RightClickBlockRequest extends Signal
	{
		public function RightClickBlockRequest()
		{
			super( Mesh );
		}
	}
}