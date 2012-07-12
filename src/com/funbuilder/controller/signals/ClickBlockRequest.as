package com.funbuilder.controller.signals
{
	import away3d.entities.Mesh;
	
	import org.osflash.signals.Signal;
	
	public class ClickBlockRequest extends Signal
	{
		public function ClickBlockRequest()
		{
			super( Mesh );
		}
	}
}